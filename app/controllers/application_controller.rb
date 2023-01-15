class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper

  def github
    @info = GithubInfo.new
  end
end
