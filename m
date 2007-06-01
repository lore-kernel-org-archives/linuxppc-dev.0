Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C119CDDDFE
	for <linuxppc-dev@ozlabs.org>; Sat,  2 Jun 2007 08:41:43 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <46604AE0.5040700@genesi-usa.com>
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
Content-Type: text/plain
Date: Sat, 02 Jun 2007 08:41:21 +1000
Message-Id: <1180737682.19517.455.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 17:35 +0100, Matt Sealey wrote:
> Re enabling proper domain support on 32-bit... now, now, now please!
> 
> X guys won't merge in code, we've been punished by both sides on Pegasos
> for nearly 12 months now after there's been a bunch of misguided attempts
> to 'fix' domain support in X. 

Well, I have commit rights on X git :-) But the current X code is too
hopeless to warrant anything but a quick hack which I don't want to do.

> The real fix is in the kernel to make it
> very clear that domains and proper, per-domain bus numbering (not
> global bus numbering) and suchlike is the standard like it is on SPARC
> and PPC64 and IA64.

Well... if the real fix means suddenly nobody can use X ...  I'm sorry
but I won't inflict that one the remaining lots of 32 bits PowerMac (and
Pegasos) users. Not until there is a fixed X available. Once Ian's work
on pci-rework X.org branch is finally merged with the trunk then life
will be better for everybody.

> If ppc32 suddenly goes the way of these, X guys will fix it, there will
> be patches to work against this kernel, even if they have to detect the
> kernel version to do it or look at a procfs or sysfs entry to fix up
> their dumb pci scanning code.

X guys would probably expect me to fix it yeah :-)

> I don't think stalling on it "because of X" is right. Fix Linux, X will
> follow, because it really has to.

Ugh ... I don't think so.

Cheers,
Ben.
