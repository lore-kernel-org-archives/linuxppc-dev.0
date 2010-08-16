Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 6AC40B70A6
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 04:20:15 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 0/9] RapidIO: Set of patches to add Gen2 switches
Date: Mon, 16 Aug 2010 11:18:59 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D6061@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C692F7E.1060208@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<4C692F7E.1060208@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>, linux-kernel@vger.kernel.org,
	Thomas Moll <thomas.moll@sysgo.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Micha Nelissen wrote:
>=20
> Alexandre Bounine wrote:
> > This set of RapidIO patches adds support for new IDT Gen2 sRIO
switch
> > devices - CPS-1848 and CPS-1616.
> > Adding these sRIO switches required to implement standard error
recovery
> > mechanism defined by the RapidIO specification.
>=20
> This is not 'Gen2' specific, as these error management extensions also
> exist in v1.2/1.3 (?) of the specification? E.g. tsi56x and tsi57x
could
> support this functionality?

Correct. EM extensions exist since v1.3. But implementation before Gen2
switches relied
on proprietary device specific mechanism (tsi57x). Addition of Gen2
switches just=20
pushed forward the standard implementation. The RIO standard methods may
be used on 1.3 switches
(tested on tsi57x) as well as the standard routing table operations that
have been added
in our patches for 2.6.35.
   =20
>=20
> Micha

Alex.
