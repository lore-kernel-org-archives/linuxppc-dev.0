Message-ID: <3B8D5E04.7FA12092@mvista.com>
Date: Wed, 29 Aug 2001 14:26:28 -0700
From: Scott Anderson <scott_anderson@mvista.com>
MIME-Version: 1.0
To: Matt Porter <mporter@mvista.com>
Cc: Brian Waite <bwaite@cspi.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to boot linux on a MVME5100
References: <85256AB7.00607D65.00@pine.cspi.com> <200108292010.QAA06333@orchid.cspi.com> <20010829095835.C31027@cx258813-a.chnd1.az.home.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Matt Porter wrote:
> Tom just moved things around recently to consolidate some bootloaders but
> you should find a ./images/zImage.initrd.pplus according to simple/Makefile.
> YMMV, I haven't tried it since before the changes.

and if that doesn't work out, you should be able to narrow the
search down by doing something like:

	$ find . -type f -newer vmlinux

Good luck,
    Scott Anderson
    scott_anderson@mvista.com   MontaVista Software Inc.
    (408)328-9214               1237 East Arques Ave.
    http://www.mvista.com       Sunnyvale, CA  94085

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
