Return-Path: <vgallardo@amcc.com>
Received: from sdcmail02.amcc.com (sdcmail02.amcc.com [198.137.200.73])
	(using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "Messaging Gateway Appliance Demo Cert",
	Issuer "Messaging Gateway Appliance Demo Cert" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 12713DDE17
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Nov 2008 05:40:20 +1100 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Subject: RE: What is the maximum memory linux support for powerpc 4xx?
Date: Wed, 5 Nov 2008 10:39:45 -0800
Message-ID: <0CA0A16855646F4FA96D25A158E299D6055053DC@SDCEXCHANGE01.ad.amcc.com>
In-Reply-To: <C332CE14-BA70-4527-BF91-ACEF8F6B6612@kernel.crashing.org>
From: "Victor Gallardo" <vgallardo@amcc.com>
To: "Kumar Gala" <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> > Hello,
> >
> > How can I figure out the and/or what is the maximum memory linux=20
> > support for powerpc 4xx?
>=20
> I'd expect the amount of memory supported to be a bit under 4G at
> this point.  There is generic work that has been going on to allow
> ALL ppc32's that have HW support for 36-bit physical to support >4G
> of memory.. however that code is likely in 2.6.29.

Thanks, Kumar.

-Victor Gallardo

- k
