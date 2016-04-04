class ExaminationResultSenderWorker
  include Sidekiq::Worker
  sidekiq_options retry: false

  def perform id
    examination = Examination.find_by id: id
    UserMailer.examination_result(examination).deliver_now
  end
end
