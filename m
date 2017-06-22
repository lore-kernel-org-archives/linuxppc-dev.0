Return-Path: <sbates@raithlin.com>
Received: from CAN01-TO1-obe.outbound.protection.outlook.com
 (mail-eopbgr670131.outbound.protection.outlook.com [40.107.67.131])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wtpVQ2MsVzDr0r
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Jun 2017 03:29:33 +1000 (AEST)
From: "Stephen  Bates" <sbates@raithlin.com>
To: Logan Gunthorpe <logang@deltatee.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-arch@vger.kernel.org"
 <linux-arch@vger.kernel.org>, "linux-ntb@googlegroups.com"
 <linux-ntb@googlegroups.com>, "linux-alpha@vger.kernel.org"
 <linux-alpha@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-crypto@vger.kernel.org"
 <linux-crypto@vger.kernel.org>, "dri-devel@lists.freedesktop.org"
 <dri-devel@lists.freedesktop.org>
CC: Arnd Bergmann <arnd@arndb.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Richard Henderson <rth@twiddle.net>, "Ivan
 Kokshaysky" <ink@jurassic.park.msu.ru>, Matt Turner <mattst88@gmail.com>
Subject: Re: [PATCH 4/7] alpha: provide ioread64 and iowrite64 implementations
Date: Thu, 22 Jun 2017 17:29:28 +0000
Message-ID: <E70FB7EB-3A05-4A08-A85E-020F47751E3B@raithlin.com>
References: <20170622164817.25515-1-logang@deltatee.com>
 <20170622164817.25515-5-logang@deltatee.com>
In-Reply-To: <20170622164817.25515-5-logang@deltatee.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiArI2RlZmluZSBpb3dyaXRlNjRiZSh2LHApIGlvd3JpdGUzMihjcHVfdG9fYmU2NCh2KSwgKHAp
KQ0KIA0KTG9nYW4sIHRoYW5rcyBmb3IgdGFraW5nIHRoaXMgY2xlYW51cCBvbi4gSSB0aGluayB0
aGlzIHNob3VsZCBiZSBpb3dyaXRlNjQgbm90IGlvd3JpdGUzMj8NCg0KU3RlcGhlbg0KDQoNCg==
