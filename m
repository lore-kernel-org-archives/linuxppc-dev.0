To: Marcio Koch <koch@inf.pucrs.br>
Cc: jffs-dev@axis.com, linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel panic using linux 2.4.2 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 05 Mar 2001 20:08:16 -0300."
             <20010305200816.D1059@sirrah.elinux.pucrs.br>
Date: Tue, 06 Mar 2001 00:38:51 +0100
Message-Id: <20010305233856.73E4E287EA@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Marcio,

in message <20010305200816.D1059@sirrah.elinux.pucrs.br> you wrote:
>
>
> I'm having some problems running linux 2.4.2 on a BSE-IP Engine. I'm using Monta Vista CDK 1.2 for development.
....
> RAMDISK: Compressed image found at block 0
> Freeing initrd memory: 4194302k freed
                         ^^^^^^^^ Looks a bit much to me...

> JFFS version 1.0, (C) 1999, 2000  Axis Communications AB
> Serial driver version 5.02 (2000-08-09) with no serial options enabled
                        ^^^^^^^^^^^^^^^^^ This is *NOT* a driver for the MPC8xx!!!

> Oops: kernel access of bad area, sig: 11
...
> My .config:
....
> #
> # Character devices
> #
> CONFIG_VT=y
> CONFIG_VT_CONSOLE=y
> CONFIG_SERIAL=y
> CONFIG_SERIAL_CONSOLE=y

You MUST NOT select CONFIG_SERIAL or CONFIG_SERIAL_CONSOLE.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Monday is an awful way to spend one seventh of your life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
