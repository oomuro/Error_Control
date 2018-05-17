@async begin
    data = 0
    expected_num = 1
    rng = MersenneTwister(1234)
    # server = listen(2000)
    sock = UDPSocket()
    bind(sock, ip"127.0.0.1", 1000)
    # conn = accept(server)
    while true
        sleep(1.0)
        trial = 1
        # data = read(conn, Int64)
        @async data = parse(Int64, String(recv(sock)))
        # sleep(1.0)
        if data == expected_num
            println("\nData Received... : $data")
            sleep(2*rand!(rng, zeros(5))[rand(1:5)])
            send(sock, ip"127.0.0.1", 2000, "$expected_num")
            println("Sending ACK... : $expected_num")
            expected_num += 1
            # break
        # else
            # println("No Data Received... Trying Again : $trial")
            # trial += 1
        end
        # write(conn, expected_num)
        # send(sock, ip"127.0.0.1", 2000, "$expected_num")
        # println("Sending ACK... : $expected_num")
        # expected_num += 1
    end
end
