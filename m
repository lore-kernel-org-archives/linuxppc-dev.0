From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15232.21084.255152.281121@cargo.ozlabs.ibm.com>
Date: Mon, 20 Aug 2001 09:57:16 +1000 (EST)
To: mlan@cpu.lu
Cc: hozer@drgw.net, linuxppc-dev@lists.linuxppc.org
Subject: Re: About TAU (and ICTC)
In-Reply-To: <200108191559.RAA01163@piglet.grunz.lu>
References: <200108191003.MAA00874@piglet.grunz.lu>
	<200108191559.RAA01163@piglet.grunz.lu>
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Michel Lanners writes:

> My preliminary test indicate that settig ICTC to 33 (0x21) has no
> noticeable effect on an idle machine. While running an endless kernel
> compile loop, however, it makes the CPU temperature drop from 19C to
> 15-17C, and increases battery life by about 20 min.

How long did each kernel compile take, with ICTC=0 and ICTC=0x21, and
what was the average current consumption in each case?

I would expect that the total battery charge used could well be higher
with ICTC=0x21 than with ICTC=0, particularly if you had the LCD
backlight on during the compile. :)

Regards,
Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
