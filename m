Return-Path: <fthain@telegraphics.com.au>
Received: from loopy.telegraphics.com.au (loopy.telegraphics.com.au
	[202.45.126.152]) by ozlabs.org (Postfix) with ESMTP id AA8D4DEBF1
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 03:46:24 +1000 (EST)
Received: from localhost (localhost [127.0.0.1])
	by loopy.telegraphics.com.au (Postfix) with ESMTP id 6A1902DCC7
	for <linuxppc-dev@ozlabs.org>; Wed, 20 Aug 2008 03:23:48 +1000 (EST)
Date: Wed, 20 Aug 2008 03:23:48 +1000 (EST)
From: Finn Thain <fthain@telegraphics.com.au>
To: linuxppc-dev@ozlabs.org
Subject: CONFIG_BOOTX_TEXT breaks PowerBook 3400 with BootX
Message-ID: <Pine.LNX.4.64.0808200148080.24338@loopy.telegraphics.com.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi All,

When I build kernels with CONFIG_BOOTX_TEXT enabled I can't boot a PB 3400 
with BootX. I get a black screen with "Welcome to Linux" at the top, then 
it appears to hang. Debian kernels are configured this way and suffer the 
same problem.

I don't know if Quik is affected. It is a bit of a hassle at install time 
since the (mediabay) floppy drive can't co-exist with the (mediabay) 
CDROM, so I'm using BootX to do the Debian install.

The Debian Sarge 2.6.8-4 kernel does not seem to have this problem though 
kernel.org 2.6.16 and later versions do.

Any ideas?

Tia,
Finn
