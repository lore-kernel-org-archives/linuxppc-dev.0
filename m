Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C4AEADDEA3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Jul 2007 11:44:02 +1000 (EST)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by de01egw02.freescale.net (8.12.11/de01egw02) with ESMTP id
	l6H1ht6w003357
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 18:43:56 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id l6H1hsdI011922
	for <linuxppc-dev@ozlabs.org>; Mon, 16 Jul 2007 20:43:55 -0500 (CDT)
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
In-Reply-To: <A76ECE36-4B72-4522-8EB0-A57359D0F938@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
	<7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
	<1184228873.27622.11.camel@localhost.localdomain>
	<2EA16557-7960-4A1A-9D07-BDA3D8843460@kernel.crashing.org>
	<1184240183.28074.113.camel@localhost.localdomain>
	<68D5EA7E-30DF-4856-8526-BABEFE230C05@kernel.crashing.org>
	<3F1CA06C-23E3-44EC-8A6E-E16BF690F664@kernel.crashing.org>
	<A76ECE36-4B72-4522-8EB0-A57359D0F938@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184636623.22868.1.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 17 Jul 2007 09:43:44 +0800
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2007-07-16 at 23:00, Segher Boessenkool wrote:
> >>>> is this the only fix, I've already applied a version of this to
> my
> >>>> tree (with the irq sense fix) and just want to make sure there  
> >>>> isn't
> >>>> anything else.
> >>> I do not get more.
> >>> I'd like to enroll Segher's suggestion together with VIA chip  
> >>> function
> >>> in next step.
> >>> We need to make basic pcie work on 8548 CDS board first.
> >>
> >> If you can, please make the "compatible" properties correct
> >> ("pcie" instead of "pciex") before the patch goes in; it'll
> >> be less work total and less confusing in the end.
> >
> > I've taken care of that as well.
> >
> > They are now 'fsl,mpc8548-pcie, and 'fsl,mpc8641-pcie'
> 
> Perfect, thanks!
I noticed Kumar made some modifications according to the feedback, when
he applied the patch.
Thanks!
Roy
