function available = compute_Availability(inputPower,PowerThresh)

if(inputPower <= PowerThresh)
    available = 0;
else
    available = 1;
end
