Date: Tue, 6 Mar 2001 16:21:38 -0300
From: Marcio Koch <koch@inf.pucrs.br>
To: Wolfgang Denk <wd@denx.de>
Cc: Marcio Koch <koch@inf.pucrs.br>, jffs-dev@axis.com,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic using linux 2.4.2
Message-ID: <20010306162138.K705@sirrah.elinux.pucrs.br>
References: <20010305200816.D1059@sirrah.elinux.pucrs.br> <20010305233856.73E4E287EA@denx.denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
In-Reply-To: <20010305233856.73E4E287EA@denx.denx.de>; from wd@denx.de on Seg, Mar 05, 2001 at 20:38:51 -0300
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Em 2001.03.05 20:38:51 -0300 Wolfgang Denk gravou:
>
> Dear Marcio,
>
> in message <20010305200816.D1059@sirrah.elinux.pucrs.br> you wrote:
> >
> >
> > I'm having some problems running linux 2.4.2 on a BSE-IP Engine. I'm using Monta Vista CDK 1.2 for development.
> ....
> > RAMDISK: Compressed image found at block 0
> > Freeing initrd memory: 4194302k freed
>                          ^^^^^^^^ Looks a bit much to me...
>
> > JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
> > Serial driver version 5.02 (2000-08-09) with no serial options enabled
>                         ^^^^^^^^^^^^^^^^^ This is *NOT* a driver for the MPC8xx!!!
>
> > Oops: kernel access of bad area, sig: 11
> ...
> > My .config:
> ....
> > #
> > # Character devices
> > #
> > CONFIG_VT=y
> > CONFIG_VT_CONSOLE=y
> > CONFIG_SERIAL=y
> > CONFIG_SERIAL_CONSOLE=y
>
> You MUST NOT select CONFIG_SERIAL or CONFIG_SERIAL_CONSOLE.

Thanks, that solved the problem.

Is that specific for the 2.4 series?  When using 2.2.xx I aways used CONFIG_SERIAL/CONFIG_SERIAL_CONSOLE and all worked fine.


Regards,

Marcio Koch
koch@inf.pucrs.br
PUCRS/ELinux


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
