Date: Wed, 29 May 2002 17:42:22 -0700
From: Matt Porter <porter@cox.net>
To: Khai Trinh <kqtrinh@yahoo.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Where to place the text section of the kernel image
Message-ID: <20020529174222.A4363@home.com>
References: <20020529223118.11673.qmail@web11504.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20020529223118.11673.qmail@web11504.mail.yahoo.com>; from kqtrinh@yahoo.com on Wed, May 29, 2002 at 03:31:18PM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Wed, May 29, 2002 at 03:31:18PM -0700, Khai Trinh wrote:
>
> I am building the ppc kernel image for Ebony. I would
> like to find out how one goes about deciding where the
> place the text section of the kernel image in memory?
> The output of the built had it put @0x800000. I looked
> in the Makefile but couldn't find where it's
> specified. More importantly, how do we decide where to
> put it? The output of the makefile is shown below:

If you put the zImage at anything less than 0x800000 then the
bootloader has to do the extra work of relocating the bootloader
and image.  The simplest approach is to simply load it at
0x800000 so it can simply uncompress the vmlinux.gz and
vector to the kernel.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
