Return-Path: <yang.reeve@gmail.com>
Received: from nz-out-0506.google.com (nz-out-0506.google.com [64.233.162.224])
	by ozlabs.org (Postfix) with ESMTP id E409D67BF4
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 12:08:49 +1100 (EST)
Received: by nz-out-0506.google.com with SMTP id l1so189642nzf
	for <linuxppc-dev@ozlabs.org>; Wed, 13 Dec 2006 17:08:48 -0800 (PST)
Message-ID: <198592450612131708h1f5b59ffhdebd1b23d56d628f@mail.gmail.com>
Date: Thu, 14 Dec 2006 01:08:47 +0000
From: "Reeve Yang" <yang.reeve@gmail.com>
To: "Hollis Blanchard" <hollis@penguinppc.org>
Subject: Re: kgdb on mpc834x
In-Reply-To: <1165982456.10549.1.camel@diesel>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <198592450612121611o7f7271cbnb1404c7f7f9fda71@mail.gmail.com>
	<1165982456.10549.1.camel@diesel>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

I set "debug serial 1" in gdb, now I'm seeing message like this

(gdb) target remote /dev/ttyS0
Remote debugging using /dev/ttyS0
[
r <Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
[<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
[<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>][<Timeout: 2 seconds>][<Timeout: 2
seconds>][<Timeout: 2 seconds>]Ignoring packet error, continuing...
Malformed response to offset query, timeout

Does it tell any information?

On 12/13/06, Hollis Blanchard <hollis@penguinppc.org> wrote:
> On Wed, 2006-12-13 at 00:11 +0000, Reeve Yang wrote:
> > I applied kgdb patch for 2.6.13 to kernel 2.6.14 (since there is no
> > patch for 2.6.14), but gdb client cannot connec to it. I turn on all
> > necessary kernel hacking options. Our board is customized with
> > MPC834x, can someoen who used kgdb to debug kernel on MPC834x help me
> > out? Following are the message from linux boot and gdb client.
> >
> > ## Booting image at ff300000 ...
> >
> > loaded at:     FF300000 FFB71124
> > relocated to:  00800000 01071124
> > board data at: 007FFF70 007FFFF8
> > relocated to:  00805114 0080519C
> > zimage at:     00805915 00926A5E
> > initrd at:     00927000 0106E242
> > avail ram:     01072000 01472000
> >
> > Linux/PPC load: mem=248M
> > Uncompressing Linux...done.
> > Now booting the kernel
> > mpc834x_sys_init(): exit
> > id mach(): done
> > MMU:enter
> > MMU:hw init
> > MMU:mapin
> > MMU:setio
> > MMU:exit
> > setup_arch: enter
> > setup_arch: bootmem
> >
> > (gdb) target remote /dev/ttyS0
> > Remote debugging using /dev/ttyS0
> > Ignoring packet error, continuing...
> > Ignoring packet error, continuing...
> > Ignoring packet error, continuing...
> > Malformed response to offset query, timeout
>
> Try 'set debug serial 1' in GDB; it will show you the actual data GDB is
> receiving.
>
> -Hollis
>
>
