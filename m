To: Dmytro Bablinyuk <dmytro.bablinyuk@tait.co.nz>
Cc: "Kevin A. Sapp" <Kevin.Sapp@catapult.com>,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: RAMDISK Segv 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 04 Dec 2003 10:38:00 +1300."
             <3FCE57B8.1080508@tait.co.nz>
Date: Thu, 04 Dec 2003 00:06:10 +0100
Message-Id: <20031203230615.DECA4C5F5F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3FCE57B8.1080508@tait.co.nz> you wrote:
>
> We had such problem with busybox and it was related to the buffer
> allocation policy (in busybox). We changed allocation policy from
> "Allocate with stack" to "Allocate with .bss" and problem gone.

The images have all been tested and are working fine here. It must be
a problem on Kevin's system - either memory map related, or the usual
culprit (SDRAM initialization).

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is an order of things in this universe.
	-- Apollo, "Who Mourns for Adonais?" stardate 3468.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
