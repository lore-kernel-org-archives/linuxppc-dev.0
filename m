Message-Id: <199904281818.UAA01127@student.physik.uni-mainz.de>
To: Geert Uytterhoeven <Geert.Uytterhoeven@cs.kuleuven.ac.be>
Subject: Re: Endianess problems in linuxppc kernel
Cc: linuxppc-dev@lists.linuxppc.org
Date: Wed, 28 Apr 1999 20:13:55 CEST
From: "Christian Bauer" <Christian.Bauer@uni-mainz.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Reply-To: Christian.Bauer@uni-mainz.de
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi!

>>   Bus  0, device  16, function  0:
>>     Unknown class: Apple Unknown device (rev 1).
>>       Vendor id=106b. Device id=7.
>>       Medium devsel.  Master Capable.  Latency=32.  
>>       Non-prefetchable 32 bit memory at 0xf3000000 [0xf3000000].
>
>Do you know which Apple chip is this, so it can be added to the pciutils
>database?

The device tree has this to say:

Devices:device-tree:bandit:ohare
#address-cells = [00000001 = 1]
#size-cells = [00000001 = 1]
AAPL,address = [f3000000 = -218103808]
assigned-addresses
class-code = [00ff0000 = 16711680]
device-id = [00000007 = 7]
device_type = "dbdma"
devsel-speed = [00000001 = 1]
max-latency = [00000000 = 0]
min-grant = [00000000 = 0]
model = "AAPL,343S0172"
name = "ohare"
ranges
reg
revision-id = [00000001 = 1]
vendor-id = [0000106b = 4203]

>You are using atyfb? What kind of ATI Mach64 chip do you have?

ATI 264VT2

>I'd say the wrong values are written to MEM_CNTL. But atyfb always writes the
>same values to MEM_CNTL, i.e. it doesn't depend on what MacOS did before?!?

Maybe the host bridge also does byte swapping on the frame buffer??

Bye,
Christian

-- 
  / Coding on PowerPC and proud of it
\/ http://www.uni-mainz.de/~bauec002/

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
