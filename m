Return-Path: <B36685@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 76514B702A
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Dec 2011 17:40:50 +1100 (EST)
From: Liu Shengzhou-B36685 <B36685@freescale.com>
To: "dedekind1@gmail.com" <dedekind1@gmail.com>
Subject: RE: [PATCH 1/2] mtd/nand: fixup for fmr initialization of Freescale
 NAND controller
Date: Tue, 20 Dec 2011 06:40:43 +0000
Message-ID: <3F453DDFF675A64A89321A1F352810216C9D5C@039-SN1MPN1-005.039d.mgd.msft.net>
References: <1323682853-10750-1-git-send-email-Shengzhou.Liu@freescale.com>
 <1324133097.4240.32.camel@sauron.fi.intel.com>
In-Reply-To: <1324133097.4240.32.camel@sauron.fi.intel.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 Gala Kumar-B11780 <B11780@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "dwmw2@infradead.org" <dwmw2@infradead.org>,
 "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFydGVtIEJpdHl1dHNraXkg
W21haWx0bzpkZWRla2luZDFAZ21haWwuY29tXQ0KPiBTZW50OiBTYXR1cmRheSwgRGVjZW1iZXIg
MTcsIDIwMTEgMTA6NDUgUE0NCj4gVG86IExpdSBTaGVuZ3pob3UtQjM2Njg1DQo+IENjOiBsaW51
eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgV29vZCBTY290dC1CMDc0MjE7DQo+IGR3bXcyQGlu
ZnJhZGVhZC5vcmc7IEdhbGEgS3VtYXItQjExNzgwOyBsaW51eC1tdGRAbGlzdHMuaW5mcmFkZWFk
Lm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMl0gbXRkL25hbmQ6IGZpeHVwIGZvciBmbXIg
aW5pdGlhbGl6YXRpb24gb2YNCj4gRnJlZXNjYWxlIE5BTkQgY29udHJvbGxlcg0KPiANCj4gT24g
TW9uLCAyMDExLTEyLTEyIGF0IDE3OjQwICswODAwLCBTaGVuZ3pob3UgTGl1IHdyb3RlOg0KPiA+
IFRoZXJlIHdhcyBhIGJ1ZyBmb3IgZm1yIGluaXRpYWxpemF0aW9uLCB3aGljaCBsZWFkIHRvICBm
bXIgd2FzIGFsd2F5cw0KPiA+IDB4MTAwIGluIGZzbF9lbGJjX2NoaXBfaW5pdCgpIGFuZCBjYXVz
ZWQgRkNNIGNvbW1hbmQgdGltZW91dCBiZWZvcmUNCj4gPiBjYWxsaW5nIGZzbF9lbGJjX2NoaXBf
aW5pdF90YWlsKCksIG5vdyB3ZSBpbml0aWFsaXplIENXVE8gdG8gbWF4aW11bQ0KPiA+IHRpbWVv
dXQgdmFsdWUgYW5kIG5vdCByZWx5aW5nIG9uIHRoZSBzZXR0aW5nIG9mIGJvb3Rsb2FkZXIuDQo+
ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaGVuZ3pob3UgTGl1IDxTaGVuZ3pob3UuTGl1QGZyZWVz
Y2FsZS5jb20+DQo+IA0KPiBQdXNoZWQgYm90aCB0byBsMi1tdGQtMi42LmdpdCwgdGhhbmtzIQ0K
PiANCj4gLS0NCj4gQmVzdCBSZWdhcmRzLA0KPiBBcnRlbSBCaXR5dXRza2l5DQoNCkkgbm90ZWQg
aXQgaGFkIGJlZW4gYXBwbGllZCBpbiBsaW51eC1uZXh0LmdpdCB0cmVlLg0KRG9lcyBpdCBzdGls
bCBuZWVkIHRvIGwyLW10ZC0yLjYuZ2l0PyANClRoYW5rcy4NCg0KQmVzdCBSZWdhcmRzLA0KU2hl
bmd6aG91IExpdQ0K
