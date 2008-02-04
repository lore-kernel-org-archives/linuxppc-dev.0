Return-Path: <sven@powerlinux.fr>
Received: from archon.plz.fr (archon.plz.fr [194.50.78.210])
	by ozlabs.org (Postfix) with ESMTP id A612DDDEED
	for <linuxppc-dev@ozlabs.org>; Mon,  4 Feb 2008 20:51:25 +1100 (EST)
Date: Mon, 4 Feb 2008 10:51:21 +0100
To: Bernhard Reiter <bernhard@intevation.de>
Subject: Re: compile quirk linux-2.6.24 (with workaround)
Message-ID: <20080204095121.GA18167@powerlinux.fr>
References: <200802031729.12069.bernhard@intevation.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200802031729.12069.bernhard@intevation.de>
From: Sven Luther <sven@powerlinux.fr>
Cc: debian-powerpc@lists.debian.org, paulus@samba.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Feb 03, 2008 at 05:29:05PM +0100, Bernhard Reiter wrote:
> Dear linux powerpc Maintainers and Users,
> 
> recently I have tried to compile a new kernel on a Debian sarge ppc
> system (PowerBook5,6 MacRISC3 Power Macintosh).

This is a G4 based system.

> The build system bailed out with
>        BOOTCC  arch/powerpc/boot/4xx.o
>         cc1: error: bad value (440) for -mcpu= switch
>         make[1]: *** [arch/powerpc/boot/4xx.o] Fehler 1
> 
> I have tracked this a few steps and the attached patch made the compile for me
> as my compiler gcc-Version 3.3.5 (Debian 1:3.3.5-13) 
> cannot produce code for 4xx it seems.

You should normally not need to build the 4xx bootloader part. Make sure
that, i don't know why this happens. Can you look into
arch/powerpc/boot/Makefile, to see what option enables the 4xx build,
and make sure it is disabled in the main config ?

Please bounce this message to debian-powerpc, as debian believes in
censorship instead of trying to solve inimity by discussion.

Friendly,

Sven Luther
