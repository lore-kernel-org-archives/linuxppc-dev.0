Message-ID: <008501c007c9$81ecbad0$fd2f7ece@kennedy>
From: "Prashant Patel" <pmpatel@myIAgent.com>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <NEBBLKHGKLJGLFPFOOABMECCCAAA.nboppuri@myiagent.com>
Subject: Testing the serial port of TQM823L
Date: Wed, 16 Aug 2000 16:32:41 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello Everyone
      I am working with TQM823L board. It has two serial ports. I am using
one serial port RS-232-2 ( and device ttyS0) to run the kernel stored in
flash. Once the kernel is running, i think i can access another serial port
RS-232-1 through device ttyS1. I have one program which writes on device
ttyS1. When i run that program, it is supposed to turn on the motor attached
to serial port RS-232-1(i.e device ttyS1).  But it didn't work. When i
tested my program with other board, it works fine.
     When i use "setserial" command, i got  following message.
>setserial -ga /dev/ttyS0
>Cannot get serial info. : invalid argument.
>setserial -ga /dev/ttyS1
>Cannot get serial info. : invalid argument
        so i don't know where i am making mistake.  How could i test whether
serial port RS-232-1 is receiving data, whenever i write to device ttyS1?
And  How could i test whether serial port RS-232-1 is live or not, after
running kernel through serial port RS-232-2 (device ttyS0).


Thanks
Prashant Patel

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
