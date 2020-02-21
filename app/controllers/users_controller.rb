class UsersController < ApplicationController
  load_and_authorize_resource
  require 'zip'
  helper_method :process_and_create_zip_file

  def index
    @users = User.all.where(:admin => false)
    @challenge_statements = ChallengeStatement.all
    @submissions = Submission.all
    respond_to do |format|
      format.xlsx {
        response.headers[
            'Content-Disposition'
        ] = "attachment; filename=Users.xlsx"
      }
      format.html { render :index }
    end
  end

  def process_and_create_zip_file
    # Simulation of an object with has_many_attached :documents
    @challenge_statement = ChallengeStatement.find(params[:challenge_statement_id])
    submissions = @challenge_statement.submissions
    if submissions.exists?
      # Tmp folder to store the download files from S3
      tmp_user_folder = "tmp/folder_for_#{@challenge_statement.title.downcase.gsub(/\s+/, '_')}"
      directory_length_same_as_documents = Dir["#{tmp_user_folder}/*"].length == submissions.length
      # Create a tmp folder if not exists
      if Dir.exists?(tmp_user_folder)
        FileUtils.rm_r(tmp_user_folder)
      end

      FileUtils.mkdir_p(tmp_user_folder) unless Dir.exists?(tmp_user_folder)
      tmp_user_zip = "#{tmp_user_folder}.zip"
      if File.exists?(tmp_user_zip)
        FileUtils.remove_file(tmp_user_zip,true)
      end
      # Download and save documents to our tmp folder
      submissions.each do |submission|
        filename = submission.title
        # User should be able to download files if not yet removed from tmp folder
        # if the folder is already there, we'd get an error
        create_tmp_folder_and_store_documents(submission, tmp_user_folder, filename)
        #---------- Convert to .zip --------------------------------------- #
        create_zip_from_tmp_folder(tmp_user_folder, filename)
      end
        # Sends the *.zip file to be download to the client's browser
      send_file(Rails.root.join("#{tmp_user_folder}.zip"), :type => 'application/zip', :filename => "Files_for_#{@challenge_statement.title.downcase.gsub(/\s+/, '_')}.zip", :disposition => 'attachment')
    end
  end

  def create_tmp_folder_and_store_documents(document, tmp_user_folder, filename)
    File.open(File.join(tmp_user_folder, filename), 'wb') do |file|
      document.file.download { |chunk| file.write(chunk) }
    end
  end

  def create_zip_from_tmp_folder(tmp_user_folder, filename)
    Zip::File.open("#{tmp_user_folder}.zip", Zip::File::CREATE) do |zf|
      zf.add(filename, "#{tmp_user_folder}/#{filename}")
    end
  end
end
