Content-Type: text/plain;
  charset="iso-8859-1"
From: Rakesh jagota <j.rakesh@gdatech.co.in>
Reply-To: j.rakesh@gdatech.co.in
To: Matt Porter <porter@cox.net>,
	Anand Franklin J <franklin@innomedia.soft.net>
Subject: Re: problem in loading image to ppc_405(IBM)
Date: Thu, 6 Nov 2003 20:10:01 +0530
Cc: ppc_embedded_maillist <linuxppc-embedded@lists.linuxppc.org>
References: <3E5620DD.AFEC3264@innomedia.soft.net> <20030221133227.A28263@home.com>
In-Reply-To: <20030221133227.A28263@home.com>
MIME-Version: 1.0
Message-ID: <zt6tshxsxyew0xp.110620032004@gda-server>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am working with the same processor, I am loading the vmlinux using
JTAG(RISCWATCH) in the SDRAM. I am not sure abt the loaction. I am loading at
0x00020000. Can you suggest me exactly atr what loaction we should load the
vmlinux image and where we should jump to start the kernel.

Thanks & regards,

Rakesh

On Saturday 22 February 2003 02:02 am, Matt Porter wrote:
> On Fri, Feb 21, 2003 at 06:21:41PM +0530, Anand Franklin J wrote:
> > Hello all,
> >     I have compiled the linux kernel (vmlinux) and used a objcopy( 'file
> > vmlinux.srec' returns --> [vmlinux.srec: Motorola S-Record; binary data
> > in text format]). But the board(ppc_405(IBM))  with OpenBios is giving
> > "invalid image error".can any body tell what is the error.
>
> vmlinux is not directly booted from OpenBios, on PPC40x one boots a
> zImage.treeboot image.
>
> Regards,


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
