@async begin
    data = 0
    expected_num = 1
    rng = MersenneTwister(1234)
    pass = Array{Int64, 1}()
    push!(pass, 0)
    sock = UDPSocket()
    bind(sock, ip"127.0.0.1", 3000)
    sleep(1.0)
    while true
        sleep(1.0)
        # @async begin
        @async data = parse(Int64, String(recv(sock)))
        if (data == expected_num) && (pass[expected_num] == 0)
        # if data == expected_num
            println("\nData Received... : $expected_num")
            sleep(3.5 + rand!(rng, zeros(5))[rand(1:5)])
            send(sock, ip"127.0.0.1", 4000, "$expected_num")
            println("Sending ACK... : $expected_num")
            pass[expected_num] = 1
            expected_num += 1
            push!(pass, 0)
            # end
        end
        # end
    end
end
