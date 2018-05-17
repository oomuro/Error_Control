seq = 1
@async begin
    seq = 1
    line = 1
    conn = connect(2000)
    sleep(1.0)
    for i in 1:20
        trial = 1
        write(conn, seq)
        println("\nSending Data... : $seq")
        while true
            @async line = read(conn, Int64)
            sleep(1.0)
            if line == seq
                println("ACK Received... : $line")
                sleep(1.0)
                seq += 1
                break
            else
                println("Failed receiving ACK... Trying Again : $trial")
                trial += 1
            end
        end
    end
end
