Return-Path: <cavok@tiscali.it>
Received: from filibusta.crema.unimi.it (filibusta.crema.unimi.it
	[159.149.70.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "filibusta.crema.unimi.it",
	Issuer "filibusta.crema.unimi.it" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 2228167B20
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  6 Apr 2006 07:13:22 +1000 (EST)
Date: Wed, 5 Apr 2006 23:06:54 +0200
From: Domenico Andreoli <cavokz@gmail.com>
To: linuxppc-embedded@ozlabs.org
Subject: freescale lite 5200 board and kernel 2.6
Message-ID: <20060405210654.GA16848@raptus.dandreoli.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

hi all,

  i've got a freescale lite 5200 evaluation board (1 pci slot), i need
it to develop the driver for a industrial labeler machine.  i was given
also some old evaluation version of metrowerks PCS and BSP stuff.

guess it.. i want to throw that software away and start from scratch
using kernel 2.6, maybe 2.6.16.

i made a cross-compiler, i built a vanilla 2.6.16 and put it on the
board's flash. i'd like to use rootfs from nfs. everything looks
promising, but vanilla 2.6.16 is not enough.

i've got some patches from patchwork.ozlabs.org (don't ask me which,
i'm not finding them any more.. one is named bcomm-to-split.diff),
re-compiled the kernel and now the board has also a network interface.

but i suspect the nic does not work correctly. sometimes kernel mounts
the rootfs, some (more) times it does not. when it does, i'm also able
to ping it from the network. conversely, i'm not.

i'm pretty confident that kernel network configuration is always right,
it is saved in the u-boot environment. network is a private one, two
hosts only.

i played a couple of days on this but i've to take a decision, time
is against me. start to develop for the old kernel 2.4 in the PCS &
BSP stuff or start with a shiny 2.6 (i've also a brand new rubini's
3rd edition "linux device drivers"!)

is there any patchset i can use for kernel 2.6? is it production-ready?
why isn't already in vanilla 2.6? has any sense to stay with kernel 2.4?

any help or hint is appreciated. thank you.

cheers
domenico

-----[ Domenico Andreoli, aka cavok
 --[ http://people.debian.org/~cavok/gpgkey.asc
   ---[ 3A0F 2F80 F79C 678A 8936  4FEE 0677 9033 A20E BC50
