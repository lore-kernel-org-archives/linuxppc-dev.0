Return-Path: <Alexandre.Bounine@idt.com>
Received: from mxout1.idt.com (mxout1.idt.com [157.165.5.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mxout1.idt.com", Issuer "idt.com" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8184EB6EE9
	for <linuxppc-dev@ozlabs.org>; Wed, 18 Aug 2010 03:20:58 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Subject: RE: [PATCH 6/9] RapidIO: Add switch-specific sysfs initialization
	callback
Date: Tue, 17 Aug 2010 10:20:09 -0700
Message-ID: <0CE8B6BE3C4AD74AB97D9D29BD24E552011D62F0@CORPEXCH1.na.ads.idt.com>
In-Reply-To: <4C6A37B3.70605@neli.hopto.org>
References: <1281712686-31308-1-git-send-email-alexandre.bounine@idt.com>
	<1281712686-31308-7-git-send-email-alexandre.bounine@idt.com>
	<4C692E4C.4040300@neli.hopto.org>
	<0CE8B6BE3C4AD74AB97D9D29BD24E552011D5FFC@CORPEXCH1.na.ads.idt.com>
	<4C6A37B3.70605@neli.hopto.org>
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
> It's not problematic, but personally I find function calls that pass 0
> or 1 as an argument hard to read. Likewise for boolean parameters. An
> alternative would be to have defines SW_SYSFS_CREATE etc. It's a minor
item.
>

I will add defines.
