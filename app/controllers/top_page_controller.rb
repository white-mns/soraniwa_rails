class TopPageController < ApplicationController
  def index
    @latest_created = Status.maximum("created_at")
    @uploaded_created = UploadedCheck.maximum("created_at")
  end
end
