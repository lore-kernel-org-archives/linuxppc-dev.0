Message-ID: <391B209B.FBCB56EB@mvista.com>
Date: Thu, 11 May 2000 14:05:31 -0700
From: Scott Anderson <sanders@mvista.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: flash drivers
References: <BE1C564723B3D21191FD0000F840E39801D81514@rfcmx2.rfc.comm.harris.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


"Brown, David (dbrown03)" wrote:
> It would be nice if we could have something like drivers/block/ftl.c without
> using patented methods.  If that's not possible, the next best thing would
> be a specific exemption for use on the linuxppc kernels, even if flash is
> on-board instead of PCMCIA.

Right now, it looks like the best course is the Journaling Flash File System
(JFFS) developed by Axis Communications.  There is an effort underway to
incorporate this with the Memory Technology Device (MTD) subsystem.  AFAIK, the
JFFS works with 2.0 kernels and there is a porting effort to get it up on 2.3
as well.  For more info on JFFS:
	http://www.developer.axis.com/software/jffs/
and of course, the MTD site already mentioned:
	http://www.linux-mtd.infradead.org/
There are also mailing lists for both of these activities.

    Scott Anderson
    scott_anderson@mvista.com	MontaVista Software Inc.
    (408)328-9214		490 Potrero Ave.
    http://www.mvista.com	Sunnyvale, CA  94086

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
