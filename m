Subject: Re: very minor 405GP and 405GPr PCI difference
From: Kenneth Johansson <kenneth.johansson@etx.ericsson.se>
To: David Gibson <david@gibson.dropbear.id.au>
Cc: andrew may <acmay@acmay.homeip.net>,
	Matt Porter <porter@cox.net>,
	Linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
In-Reply-To: <20021009015828.GO32555@zax>
References: <20020930040143.GF10265@zax> <20021001052121.GV10265@zax>
	<3D995EC0.2000500@elsoft.ch> <20021002014219.GF1848@zax>
	<3D9AA452.5070004@elsoft.ch> <20021003011233.GC1102@zax>
	<20021006052314.GG27824@acmay.homeip.net> <20021006183120.A17129@home.com>
	<20021008041419.GF32555@zax> <20021008052136.GA26470@acmay.homeip.net>
	<20021009015828.GO32555@zax>
Content-Type: text/plain
Date: 09 Oct 2002 12:35:17 +0200
Message-Id: <1034159717.1600.89.camel@spawn>
Mime-Version: 1.0
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, 2002-10-09 at 03:58, David Gibson wrote:
>
> That's all very well if you've got PPCboot, but lots of boards have
> firmware which is, lets face it, shite.  The kernel has to be able to
> deal with this case.  And since it has to deal with it for the case of
> crappy firmware, is there any point turning it off for the case of
> decent firmware?

I think it's a good idea to isolate the kernel as much as possible from
the bootloader. This way you cut down on strange bugs that could depend
not on the kernel but on the firmware.

What do we really gain by trusting the firmware for anything but the
most basic stuff like some timing values and dram setup.


--
Kenneth Johansson
Ericsson AB                       Tel: +46 8 404 71 83
Borgafjordsgatan 9                Fax: +46 8 404 72 72
164 80 Stockholm                  kenneth.johansson@etx.ericsson.se


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
