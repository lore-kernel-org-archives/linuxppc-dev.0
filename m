Message-ID: <001b01c4121a$00a24260$150a0a0a@netoriented.com>
Reply-To: "Tang Nguyen" <tang@netoriented.com>
From: "Tang Nguyen" <tang@netoriented.com>
To: <linuxppc-embedded@lists.linuxppc.org>
Subject: APC overflow
Date: Wed, 24 Mar 2004 19:33:55 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am porting 860sar version 2.2 on my system, which run @100Mhz for system
clock and @50Mhz for Bus clock.  The ESAR driver was initialized very
clean - but when I start passing UBR traffic, I always got APC overflow
interrupt.  The physical rate of my system is 2.3MHz - and I have configured
the PCR to 5424 - It should be OK but I have no idea why I got APC over flow
interrupt.  Any help and suggestion from you would be greatly appreciated.

-t


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
