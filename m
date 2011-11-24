Return-Path: <r58472@freescale.com>
Received: from VA3EHSOBE010.bigfish.com (va3ehsobe010.messaging.microsoft.com
 [216.32.180.30]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 19D181007D7
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2011 18:49:10 +1100 (EST)
From: Li Yang-R58472 <r58472@freescale.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>, Liu Shuo-B35362
 <B35362@freescale.com>
Subject: RE: [PATCH 3/3] mtd/nand : workaround for Freescale FCM to support
 large-page Nand chip
Date: Thu, 24 Nov 2011 07:49:03 +0000
Message-ID: <3F607A5180246847A760FD34122A1E052DC61F@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1322095306-13156-1-git-send-email-b35362@freescale.com>
 <1322095306-13156-3-git-send-email-b35362@freescale.com>
 <1322120515.24797.296.camel@sauron.fi.intel.com>
In-Reply-To: <1322120515.24797.296.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "Artem.Bityutskiy@nokia.com" <Artem.Bityutskiy@nokia.com>,
 Wood Scott-B07421 <B07421@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
 "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBTdWJqZWN0OiBSZTogW1BBVENIIDMvM10gbXRkL25hbmQgOiB3b3JrYXJvdW5kIGZvciBGcmVl
c2NhbGUgRkNNIHRvIHN1cHBvcnQNCj4gbGFyZ2UtcGFnZSBOYW5kIGNoaXANCj4gDQo+IE9uIFRo
dSwgMjAxMS0xMS0yNCBhdCAwODo0MSArMDgwMCwgYjM1MzYyQGZyZWVzY2FsZS5jb20gd3JvdGU6
DQo+ID4gKyAgICAgICAgICAgICAgIC8qDQo+ID4gKyAgICAgICAgICAgICAgICAqIEZyZWVzY2Fs
ZSBGQ00gY29udHJvbGxlciBoYXMgYSAySyBzaXplIGxpbWl0YXRpb24gb2YgYnVmZmVyDQo+ID4g
KyAgICAgICAgICAgICAgICAqIFJBTSwgc28gZWxiY19mY21fY3RybC0+YnVmZmVyIGhhdmUgdG8g
YmUgdXNlZCBpZiB3cml0ZXNpemUNCj4gPiArICAgICAgICAgICAgICAgICogb2YgY2hpcCBpcyBn
cmVhdGVyIHRoYW4gMjA0OC4NCj4gPiArICAgICAgICAgICAgICAgICogV2UgbWFsbG9jIGEgbGFy
Z2UgZW5vdWdoIGJ1ZmZlciAobWF4aW11bSBwYWdlIHNpemUgaXMNCj4gMTZLKS4NCj4gPiArICAg
ICAgICAgICAgICAgICovDQo+ID4gKyAgICAgICAgICAgICAgIGVsYmNfZmNtX2N0cmwtPmJ1ZmZl
ciA9IGttYWxsb2MoMTAyNCAqIDE2ICsgMTAyNCwNCj4gR0ZQX0tFUk5FTCk7DQo+IA0KPiBBcmUg
dGhlcmUgTkFORHMgd2l0aCAxNktpQiBwYWdlIHNpemU/DQoNCldlIGFyZSBub3Qgc3VyZSwgYnV0
IGFyZSB0aGVyZSBwb3NzaWJpbGl0eSB0aGF0IGNoaXAgd2l0aCAxNksgcGFnZSB3aWxsIGFwcGVh
cj8gIE9yIG1heWJlIHdlIGNhbiBhZGQgYSBNQUNSTyBmb3IgdGhlIG1heGltdW0gcGFnZSBzaXpl
Pw0KDQotIExlbw0K
