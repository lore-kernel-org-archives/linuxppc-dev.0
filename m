Message-ID: <3E92A455.5040709@imc-berlin.de>
Date: Tue, 08 Apr 2003 12:28:37 +0200
From: Steven Scholz <steven.scholz@imc-berlin.de>
MIME-Version: 1.0
To: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: I2C RTC causes boot delay...
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi there,

I have an I2C RTC connected to my MPC855T to substitute the internal one.

I noticed that between

    Verifying Checksum ... OK
    Uncompressing Kernel Image ... OK

and the next lines printed while booting "nothing" happens for THREE
seconds.

I reckon that is has something to do with not having an external 32kHz
clock on the MPC. But I can't find the place in the sources!

Could someone please give me a hint where to look.

Can I just skipped this part then for my board. Or do I realy need an
external 32kHz for running linux?

Thanks,

Steven


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
