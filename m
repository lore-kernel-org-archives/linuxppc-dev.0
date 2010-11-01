Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A5E2B7144
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Nov 2010 02:50:10 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: Support for multiple port's
Date: Mon, 1 Nov 2010 08:49:58 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552014B9D3A@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <AANLkTin7OeSgUgqUEnYxUnZQ0vgckg7e43gudms8NqeG@mail.gmail.com>
References: <AANLkTin7OeSgUgqUEnYxUnZQ0vgckg7e43gudms8NqeG@mail.gmail.com>
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
> Going through the code, it looks like the rapidio driver assumes
> there's only going to be a single Port implemented.

Yes, this is true for the current implementation.

> On the newer QorIQ P2020 processors there are 2 sets of port
> registers, so the current code lays the dbell_atmu_regs structure on
> top of the second set of atmu_regs.  There are probably other issues
> as well.

There are issues with multiport support in RIO subsystem code as well .

>=20
> Are there any patch sets available that support the newer processors,
> and multi-port ( multi-homed? ) RapidIO configurations?

I am planning a patch for RIO subsystem - this will not address issues
with FSL mport driver.

>=20
> Thanks!
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
