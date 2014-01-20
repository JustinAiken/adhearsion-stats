class FakeUDPSocket
  def buffer
    @buffer ||= []
  end

  def send(message, *rest)
    buffer.push [message]
  end

  def to_s; buffer; end
end

class FakeStatsd < Statsd
  def socket
    @socket ||= FakeUDPSocket.new
  end
end
