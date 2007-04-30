Return-Path: <kim.phillips@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id EBF86DDF11
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  1 May 2007 04:52:15 +1000 (EST)
Date: Mon, 30 Apr 2007 13:52:00 -0500
From: Kim Phillips <kim.phillips@freescale.com>
To: Alex Zeffertt <ajz@cambridgebroadband.com>
Subject: Re: Anyone using mpc832x_mds & freescale's GIT repo?
Message-Id: <20070430135200.23bb6bbf.kim.phillips@freescale.com>
In-Reply-To: <4636081D.2000507@cambridgebroadband.com>
References: <4636081D.2000507@cambridgebroadband.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Mon, 30 Apr 2007 16:15:41 +0100
Alex Zeffertt <ajz@cambridgebroadband.com> wrote:

> Hi list,
> 
> I've got an MPC8323E-MDS-PB development board, which is
> running a year-old BSP from freescale.  I wanted to track
> the most current developments so I cloned
> 
> 	http://opensource.freescale.com/pub/scm/linux-2.6-83xx.git
> 
that tree is obsolete; I'll label it so to avoid confusion.

> and rebuilt with ARCH=powerpc and using the mpc832x_mds_defconfig.
> 
> I now don't get any serial console output after u-boot has
> started the kernel.
> 
> My questions are:
> 
> 1.	Is anyone else using this GIT repo with this board?
> 
please use the mpc83xx custodian tree on denx.de:

{git-,cg-}{clone,pull} git://www.denx.de/git/u-boot-mpc83xx.git

> 2.	Is there an example u-boot environment for starting the latest kernels
> 	on this board?

the nfsboot and ramboot commands found in that board's default
environment specify the fdt address with the new bootm syntax.

> 
> 3.	Am I using the right ARCH.  (I chose ARCH=powerpc because there's
> 	no defconfig file for this board under arch/ppc!)
> 
yup.

Kim
