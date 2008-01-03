Return-Path: <Tony.Li@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 33A4ADDE47
	for <linuxppc-dev@ozlabs.org>; Thu,  3 Jan 2008 17:10:11 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	m0369wcB012747
	for <linuxppc-dev@ozlabs.org>; Wed, 2 Jan 2008 23:09:59 -0700 (MST)
Received: from zch01exm21.fsl.freescale.net (zch01exm21.ap.freescale.net
	[10.192.129.205])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id m0369vDK008456
	for <linuxppc-dev@ozlabs.org>; Thu, 3 Jan 2008 00:09:57 -0600 (CST)
Subject: Re: [PATCH] powerpc: Add MPC837x PCIE controller RC mode support
From: Li Li <r64360@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <901A2F2F-D072-4F03-AA39-9AB6A56EA635@kernel.crashing.org>
References: <1199272605.22416.8.camel@Guyver>
	<901A2F2F-D072-4F03-AA39-9AB6A56EA635@kernel.crashing.org>
Content-Type: text/plain
Date: Thu, 03 Jan 2008 13:56:16 +0800
Message-Id: <1199339776.7375.1.camel@Guyver>
Mime-Version: 1.0
Cc: Wood Scott <scottwood@freescale.com>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Phillips Kim <Kim.Phillips@freescale.com>, Li Tony <Tony.Li@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-01-02 at 23:23 +0800, Kumar Gala wrote:
> 
> On Jan 2, 2008, at 5:16 AM, Li Li wrote:
> 
> > * The MPC837x PCIE controller hardware resources and SerDes are  
> > initiated in u-boot. 
> > * Merge the MPC837x PCIE code into arch/powerpc/sysdev/fsl_pci.c 
> > * The MPC837x PCIE controller`s configure address bit field is
> uniqe: 
> >       bus number:             bits 31-24 
> >       device number:          bits 23-19 
> >       function number:        bits 18-16 
> >       ext reg number:         bits 11-8 
> >       reg number:             bits 7-2 
> > * Add mpc837x_exclude_device to fixup a controller bug.
> 
> what is the bug that is being worked around?
> 
For Type 0 configure transactions, the PCIE controller do not check the
device number bits and just assume the device number bits are 0.

- tony
