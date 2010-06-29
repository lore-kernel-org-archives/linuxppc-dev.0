Return-Path: <B07421@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 09403B6EF7
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Jun 2010 05:12:03 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.14.3/de01egw01-8.14.3) with ESMTP id
	o5TIuIXd029892
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 11:56:19 -0700 (MST)
Received: from az33exm25.fsl.freescale.net (az33exm25.am.freescale.net
	[10.64.32.16])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id o5TJ7rRc006692
	for <linuxppc-dev@ozlabs.org>; Tue, 29 Jun 2010 14:07:54 -0500 (CDT)
Date: Tue, 29 Jun 2010 13:56:17 -0500
From: Scott Wood <scottwood@freescale.com>
To: Shawn Jin <shawnxjin@gmail.com>
Subject: Re: machine check in kernel for a mpc870 board
Message-ID: <20100629185617.GA24285@schlenkerla.am.freescale.net>
References: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTinA2ghLxBU41aFAsLM1oXQ8HMASx1eQMDVvi56n@mail.gmail.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Jun 29, 2010 at 12:59:56AM -0700, Shawn Jin wrote:
> I'm porting a mpc870 board to the powerpc arch. The base is the
> adder-875 board. My first try to boot the cuImage.my870 is
> experiencing a machine check. And I have no clue where to look. Any
> help?
> 
> => bootm 1000000
> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.33.5
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    747319 Bytes = 729.8 kB
>    Load Address: 00400000
>    Entry Point:  004004d4
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
> Bus Fault @ 0x00404c40, fixup 0x00000000
> Machine check in kernel mode.
> Caused by (from msr): regs 07d1cb80 Unknown values in msr
> NIP: 00404C40 XER: 00000000 LR: 00404C24 REGS: 07d1cb80 TRAP: 0200 DAR: 00000001
> MSR: 00001002 EE: 0 PR: 0 FP: 0 ME: 1 IR/DR: 00

Can you look up the source line/instruction corresponding to 0x404c40, in
the wrapper ELF file?

-Scott
