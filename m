Date: Wed, 29 Aug 2001 09:58:35 -0700
From: Matt Porter <mporter@mvista.com>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to boot linux on a MVME5100
Message-ID: <20010829095835.C31027@cx258813-a.chnd1.az.home.com>
References: <85256AB7.00607D65.00@pine.cspi.com> <200108292010.QAA06333@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108292010.QAA06333@orchid.cspi.com>; from bwaite@cspi.com on Wed, Aug 29, 2001 at 04:02:35PM -0400
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 29, 2001 at 04:02:35PM -0400, Brian Waite wrote:
>
> I am also using an MVME5100 it works so far except with the new 2.4.9 devel
> tree I can  no longer build a zImage.initrd. make zImage.initrd completes and
> is happy, but I never find the file in the tree anywahere. I have cheked pp3,
> prep, common, simple and images. The most I can find is a vmlinux.gz Any
> ideas on this?

Tom just moved things around recently to consolidate some bootloaders but
you should find a ./images/zImage.initrd.pplus according to simple/Makefile.
YMMV, I haven't tried it since before the changes.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
