Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id DF0DDDDE20
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:55:55 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <b972e02fc13915c5eb888621c771abb9@kernel.crashing.org>
References: <11798051102658-git-send-email-wei.zhang@freescale.com>
	<11798051101543-git-send-email-wei.zhang@freescale.com>
	<1179805110272-git-send-email-wei.zhang@freescale.com>
	<1179805110278-git-send-email-wei.zhang@freescale.com>
	<1179856792.27985.22.camel@rhino>
	<46B96294322F7D458F9648B60E15112C234A2D@zch01exm26.fsl.freescale.net>
	<F1C4E37E-FF0F-4A5F-AC49-860B4AAC4E28@kernel.crashing.org>
	<46B96294322F7D458F9648B60E15112C30777C@zch01exm26.fsl.freescale.net>
	<A7C2B8A9-AE89-4E00-9771-F3C21A610121@kernel.crashing.org>
	<18015.48278.312517.781244@cargo.ozlabs.ibm.com>
	<46B96294322F7D458F9648B60E15112C30780F@zch01exm26.fsl.freescale.net>
	<1180683854.19517.419.camel@localhost.localdomain>
	<46604AE0.5040700@genesi-usa.com>
	<1180737682.19517.455.camel@localhost.localdomain>
	<b972e02fc13915c5eb888621c771abb9@kernel.crashing.org>
Content-Type: text/plain
Date: Sat, 02 Jun 2007 18:55:41 +1000
Message-Id: <1180774541.14025.3.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Zhang Wei-r63237 <Wei.Zhang@freescale.com>,
	Paul Mackerras <paulus@samba.org>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Sat, 2007-06-02 at 10:36 +0200, Segher Boessenkool wrote:
> In the meantime, you could have a kernel config option
> selecting between "good new" and "bad old" ppc32 PCI
> stack.  At the very least it will make it easier for both
> kernel and X people to test their stuff.  Also it will
> allow users to switch to the bad old but working stack
> if things don't go too smoothly during the transition.

Could be a boot or platform option.. basically enabling unconditional
outputing of domains ... plus a few other things like removing iobase
syscall etc..

Ben.
