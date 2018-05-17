@async begin
    seq = 1
    line = 0
    trial = 1
    # conn = connect(2000)
    sock = UDPSocket()
    bind(sock, ip"127.0.0.1", 2000)
    while true
        sleep(1.0)
        # write(conn, seq)
        send(sock, ip"127.0.0.1", 1000, "$seq")
        println("\nSending Data... : $seq")
        # while true
        # @async line = read(conn, Int64)
        @async line = parse(Int64, String(recv(sock)))
        # sleep(1.0)
        if line == seq
            println("ACK Received... : $line")
            sleep(1.0)
            seq += 1
            trial = 1
            # break
        else
            println("Failed Receiving ACK... Retry : $trial")
            sleep(1.0)
            # println("Failed receiving ACK... Trying Again : $trial")
            # println("Wrong ACK... : $line")
            trial += 1
        end
            # break
        # end
    end
end
