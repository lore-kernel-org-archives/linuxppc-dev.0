Return-Path: <dale@farnsworth.org>
Date: 10 Jul 2007 06:22:07 -0700
Message-ID: <20070710132207.12018.qmail@farnsworth.org>
From: "Dale Farnsworth" <dale@farnsworth.org>
To: psyphi@gmail.com, Linuxppc-embedded@ozlabs.org
Subject: Re: [kernel-2.6.19]Marvell GT-64260 and Ethernet
In-Reply-To: <13b81f0c0707092336r5c7f4996u6f9c73d95c63bdc6@mail.gmail.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

> I'm porting a Linux kernel 2.6.19 on a PowerPC 750 FX board.
> My Linux runs completely except for Ethernet. I don't find any Ethernet
> driver for my bridge. Do you know if there is an Ethernet driver for the
> Marvell GT-64260 bridge for PowerPC processor. I found a GT-64260 ethernet
> driver in the kernel 2.4.34 for MIPS processor, will it be possible to port
> it in a 2.6 kernel?

I believe that Steve Hill <sjhill@realitydiluted.com> has patched
the mv643xx_eth driver to work with the 64260 and plans to submit
the patches.

-Dale
