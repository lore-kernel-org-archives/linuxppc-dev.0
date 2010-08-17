Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id BC231B70D4
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Aug 2010 22:45:07 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 7/9] RapidIO: Add handling for PW message from a lost
	device
Date: Tue, 17 Aug 2010 05:44:25 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D61BF@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6A38A4.6070505@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-8-git-send-email-alexandre.bounine@idt.com>
	<4C692F31.2020705@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D6040@CORPEXCH1.na.ads.idt.com>
	<4C6A38A4.6070505@neli.hopto.org>
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
> Perhaps an idea is to use the repeated port-write sending feature so
> that dropped port-writes are not a problem anymore.
>=20
Unfortunately, this feature is not defined by RIO spec. This is
proprietary function, so we=20
cannot rely on it. Yes, this is nice feature of Tsi57x switches and may
be used if you have=20
a closed system - just enable it in em_init. The RIO spec part 8 is
quite open about port-write generation and we cannot expect the same
behavior from different devices.   =20
