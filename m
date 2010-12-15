Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id F281DB6F11
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 16 Dec 2010 01:02:25 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: RapidIO: multiple mport support for QorIQ
Date: Wed, 15 Dec 2010 06:02:08 -0800
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E5520169B5C0@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
References: <AANLkTinwP6kQvWjSO3cxNUqd7tx7dhGEShTdKQXj-+iD@mail.gmail.com>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Thomas Taranowski" <tom@baringforge.com>, <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Thomas Taranowski wrote:
=20
> I'm planning to add support for the multiple(2) mports supported by
> the Freescale p2020 processor.  I'm currently looking at the fsl layer
> to add in support for multiple port enumeration, and work up from
> there.  It looks like the upper layers already have at least partial
> support for this.  My question is, are there any efforts already
> ongoing I can hop in on so as not to duplicate effort?  If not, I'll
> just do it.
>=20
I am working on multiple port support in RapidIO subsystem.
This work is not related to FSL driver - I have a PCI RapidIO controller
which will be added into the subsystem as well. If everything goes as
planned, I hope to publish the first version of new patches in the
second half of January.
 =20
=20
