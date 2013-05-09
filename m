Return-Path: <B02008@freescale.com>
Received: from db8outboundpool.messaging.microsoft.com
 (mail-db8lp0184.outbound.messaging.microsoft.com [213.199.154.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 029992C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 May 2013 21:34:07 +1000 (EST)
From: Caraman Mihai Claudiu-B02008 <B02008@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>
Subject: RE: [v1][KVM][PATCH 1/1] kvm:ppc:booehv: direct ISI exception to Guest
Date: Thu, 9 May 2013 11:34:06 +0000
Message-ID: <300B73AA675FCE4A93EB4FC1D42459FF3F7FBE@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1367970043.3398.39@snotra> <5189B02E.3000109@windriver.com>
 <300B73AA675FCE4A93EB4FC1D42459FF3EFA26@039-SN2MPN1-013.039d.mgd.msft.net>
 <518A1AD8.3090103@windriver.com> <518B7913.6010302@windriver.com>
In-Reply-To: <518B7913.6010302@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "agraf@suse.de" <agraf@suse.de>,
 "kvm-ppc@vger.kernel.org" <kvm-ppc@vger.kernel.org>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+PiBWRiBzdGFuZHMgZm9yIHZpcnR1YWxpemF0aW9uIGZhdWx0IHNlZSBNQVM4W1ZGXSBhbmQg
d2UgbWF5IHVzZSBpdCBmb3INCj4gdmlydHVhbGl6ZWQNCj4gDQo+IExvb2tzIEtWTSBQUEMgaGF2
ZSBubyB0aGlzIG1lY2hhbmlzbSBjdXJyZW50bHkgc2luY2UgSSBkb24ndCBmaW5kIE1BUzhfVkYN
Cj4gaXMNCj4gdXNlZCBpbiBrZXJuZWwsIHJpZ2h0Pw0KDQpZZXMgYnV0ICd3ZSBtYXkgdXNlIGl0
JyBpbiB0aGUgZmVhdHVyZSwgSSBoYXZlIGEgZnVuY3Rpb25hbCBQT0Mgd2l0aCBWRi4NCk5vdyB3
ZSBjYXB0dXJlIHZpcnR1YWxpemVkIE1NSU8gYWNjZXNzZXMgYXMgVExCIG1pc3NlcyAod2UgZG9u
J3Qgd3JpdGUNCmludG8gSFcgVExCIGd1ZXN0IHRyYW5zbGF0aW9uIG91dHNpZGUgdmlzaWJsZSBt
ZW1zbG90cykuDQoNCi1NaWtlDQo=
