Message-ID: <3EFC6C86.5010801@tataelxsi.co.in>
Date: Fri, 27 Jun 2003 21:40:46 +0530
From: "Omanakuttan" <omanakuttan@tataelxsi.co.in>
MIME-Version: 1.0
To: Srini Amble <samble@xopworks.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: jumbled characters on serial port
References: <3EFC634F.5040604@tataelxsi.co.in> <3EFC66FE.4050301@xopworks.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


>
> Have you tried playing around with the baud rate settings, parity
> settings, stop/data/start bit setting? From what you have mentioned I
> suspect the problem is with the mismatched settings I have listed
> before. Please make sure that the port on your host (on which minicom is
> running) is set to match with what your serial port on your target is
Yes, I have tried these settings.
Let me explain the problem like this,
starting minicom and set the baud rate, xon/xoff and hardware
flowcontrol and parity to correct values.
We begin getting messages on the tty, without any problem.
We do insmod ...etc for the driver. Now during the testing some packts
re passed (say 500.) suddenly the characters gets jumbled after printing
some data which we cannot get.
Sometime if the secondary font is set, then minicom exiting and
restarting will set the primary font back. Here it does not happen.

Do you want to me change the parity/xor/flowcontrol..etc once this
problem occurs? I will give that a shot too..
Thanks
Om.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
