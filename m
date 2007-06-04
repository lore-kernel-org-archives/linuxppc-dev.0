Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 635DDDDEBE
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 05:03:44 +1000 (EST)
Subject: Re: [PATCH 3/5] Float the pci bus number on MPC8641HPCN board.
From: Jon Loeliger <jdl@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
In-Reply-To: <1180740531.19517.480.camel@localhost.localdomain>
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
	<CD8461E1-1881-407C-BE62-3679AECAE5AA@kernel.crashing.org>
	<1180740531.19517.480.camel@localhost.localdomain>
Content-Type: text/plain
Message-Id: <1180983654.9632.28.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Mon, 04 Jun 2007 14:00:54 -0500
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>, Wei Zhang <Wei.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2007-06-01 at 18:28, Benjamin Herrenschmidt wrote:
> On Fri, 2007-06-01 at 14:58 -0500, Kumar Gala wrote:
> > 
> > So looking at the code it looks like pci_assign_all_buses should  
> > handle numbering the busses properly when we scan the busses, so  
> > what's the issue that causes that not to be correct? 
> 
> Yeah, that's what powermac uses... Any reason it wouldn't work ?
> 
> Ben.

Empirical testing says it doesn't work.

jdl
