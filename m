Date: Fri, 21 Feb 2003 13:32:28 -0700
From: Matt Porter <porter@cox.net>
To: Anand Franklin J <franklin@innomedia.soft.net>
Cc: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: problem in loading image to ppc_405(IBM)
Message-ID: <20030221133227.A28263@home.com>
References: <3E5620DD.AFEC3264@innomedia.soft.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3E5620DD.AFEC3264@innomedia.soft.net>; from franklin@innomedia.soft.net on Fri, Feb 21, 2003 at 06:21:41PM +0530
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Feb 21, 2003 at 06:21:41PM +0530, Anand Franklin J wrote:
>
> Hello all,
>     I have compiled the linux kernel (vmlinux) and used a objcopy( 'file
> vmlinux.srec' returns --> [vmlinux.srec: Motorola S-Record; binary data
> in text format]). But the board(ppc_405(IBM))  with OpenBios is giving
> "invalid image error".can any body tell what is the error.

vmlinux is not directly booted from OpenBios, on PPC40x one boots a
zImage.treeboot image.

Regards,
--
Matt Porter
porter@cox.net
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
