Date: Wed, 29 Aug 2001 16:32:56 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Brian Waite <bwaite@cspi.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: trying to boot linux on a MVME5100
Message-ID: <20010829163256.E18618@cpe-24-221-152-185.az.sprintbbd.net>
References: <85256AB7.00607D65.00@pine.cspi.com> <200108292010.QAA06333@orchid.cspi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200108292010.QAA06333@orchid.cspi.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, Aug 29, 2001 at 04:02:35PM -0400, Brian Waite wrote:

> I am also using an MVME5100 it works so far except with the new 2.4.9 devel
> tree I can  no longer build a zImage.initrd. make zImage.initrd completes and
> is happy, but I never find the file in the tree anywahere. I have cheked pp3,
> prep, common, simple and images. The most I can find is a vmlinux.gz Any
> ideas on this?

G'arg...  It really should be:
arch/ppc/boot/images/zImage.initrd.{pplus,bugboot}

I'll go and make a quick dummy ramdisk and try this..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
