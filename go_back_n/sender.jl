@async begin
    w = 5
    seq = 1
    seq_min = 1
    seq_max = w
    data = 0
    p = 0
    q = 0
    sock = UDPSocket()
    bind(sock, ip"127.0.0.1", 4000)
    sleep(1.0)
    while true
        @async for i in seq_min:seq_max
            send(sock, ip"127.0.0.1", 3000, "$i")
            println("\nSending Data... : $i")
            sleep(1.0)
        end
        @goto q
        @label p
        @async begin
            send(sock, ip"127.0.0.1", 3000, "$seq")
            println("\nSending Data... : $seq")
            sleep(1.0)
        end
        @label q
        # @async begin
        sleep(4.0)
        @async data = parse(Int64, String(recv(sock)))
        if data == seq
            println("ACK Received... : $data")
            seq_min += 1
            seq_max += 1
            seq += 1
        else
            println("Failed Receiving ACK...")
            seq_min = seq
            seq_max = seq + w
            @goto p
        end
        # end
    end
end
