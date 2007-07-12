Return-Path: <tie-fei.zang@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 3C458DDDFB
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 21:36:42 +1000 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l6CBabZU023485
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 04:36:37 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l6CBaZWJ007450
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Jul 2007 06:36:36 -0500 (CDT)
Subject: Re: [patch 3/6] Add 8548 CDS PCI express controller node and PCI-X
	device node
From: Zang Roy-r61911 <tie-fei.zang@freescale.com>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <2EA16557-7960-4A1A-9D07-BDA3D8843460@kernel.crashing.org>
References: <1184082728.20129.187.camel@localhost.localdomain>
	<963D5B48-F1E5-4930-9F29-98D7F0E33C0A@kernel.crashing.org>
	<1184121840.22066.24.camel@localhost.localdomain>
	<0E17851B-A642-43E2-9A5D-39DFC6F30E77@kernel.crashing.org>
	<7431AAFD-73B7-4337-94CB-878285D298E3@kernel.crashing.org>
	<1184228873.27622.11.camel@localhost.localdomain>
	<2EA16557-7960-4A1A-9D07-BDA3D8843460@kernel.crashing.org>
Content-Type: text/plain
Message-Id: <1184240183.28074.113.camel@localhost.localdomain>
Mime-Version: 1.0
Date: 12 Jul 2007 19:36:23 +0800
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

On Thu, 2007-07-12 at 17:00, Kumar Gala wrote:
> On Jul 12, 2007, at 3:27 AM, Zang Roy-r61911 wrote:
> 
> > From: Roy Zang <tie-fei.zang@freescale.com>
> >
> > Add 8548 CDS PCI express controller node and PCI-X device node.
> > The current  dts file is suitable for 8548 Rev 2.0 board with
> > Arcadia 3.1.
> > This kind of board combination is the most popular.
> >
> > Indentify pci, pcie host by compatible property "fsl,mpc85xx-pci"
> > and "fsl, mpc85xx-pciex".
> >
> > Signed-off-by: Roy Zang <tie-fei.zang@freescale.com>
> > ---
> > Fix the PCI Express b,c,d, irq sense.
> 
> is this the only fix, I've already applied a version of this to my  
> tree (with the irq sense fix) and just want to make sure there isn't  
> anything else.
I do not get more.
I'd like to enroll Segher's suggestion together with VIA chip function
in next step.
We need to make basic pcie work on 8548 CDS board first.
Thanks.

Roy
