Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id EF7C8B6F0D
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 03:16:30 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 2/9] RapidIO,
	powerpc/85xx: modify RIO port-write interrupt handler
Date: Tue, 17 Aug 2010 10:16:08 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D62E8@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6A3665.7030207@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-3-git-send-email-alexandre.bounine@idt.com>
	<4C692B42.9050407@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D5F94@CORPEXCH1.na.ads.idt.com>
	<4C6A3665.7030207@neli.hopto.org>
From: "Bounine, Alexandre" <Alexandre.Bounine@idt.com>
To: "Micha Nelissen" <micha@neli.hopto.org>
Cc: linuxppc-dev@ozlabs.org, akpm@linux-foundation.org,
	linux-kernel@vger.kernel.org, "Bounine,
	Alexandre" <Alexandre.Bounine@idt.com>
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
> Primarily due to the single entry queue, the order of checking is
> probably insignificant? :-)

Help sometimes only but gives a feeling that I did all that is possible
;)=20

> Anyway, I don't mind changing the order.
>=20
> Micha
