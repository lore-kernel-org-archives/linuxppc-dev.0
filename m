Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-10.arcor-online.net (mail-in-10.arcor-online.net
	[151.189.21.50])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6EAB4DDEB9
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 18:36:17 +1000 (EST)
In-Reply-To: <1180737682.19517.455.camel@localhost.localdomain>
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
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <b972e02fc13915c5eb888621c771abb9@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
Date: Sat, 2 Jun 2007 10:36:11 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
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

>> The real fix is in the kernel to make it
>> very clear that domains and proper, per-domain bus numbering (not
>> global bus numbering) and suchlike is the standard like it is on SPARC
>> and PPC64 and IA64.
>
> Well... if the real fix means suddenly nobody can use X ...  I'm sorry
> but I won't inflict that one the remaining lots of 32 bits PowerMac 
> (and
> Pegasos) users. Not until there is a fixed X available. Once Ian's work
> on pci-rework X.org branch is finally merged with the trunk then life
> will be better for everybody.

In the meantime, you could have a kernel config option
selecting between "good new" and "bad old" ppc32 PCI
stack.  At the very least it will make it easier for both
kernel and X people to test their stuff.  Also it will
allow users to switch to the bad old but working stack
if things don't go too smoothly during the transition.


Segher
