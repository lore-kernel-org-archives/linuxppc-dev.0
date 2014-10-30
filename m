Return-Path: <Varun.Sethi@freescale.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2A3541A00AF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 31 Oct 2014 03:46:12 +1100 (AEDT)
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 247D61400A0
 for <linuxppc-dev@ozlabs.org>; Fri, 31 Oct 2014 03:46:10 +1100 (AEDT)
From: Varun Sethi <Varun.Sethi@freescale.com>
To: Emilian Medve <Emilian.Medve@freescale.com>, Scott Wood
 <scottwood@freescale.com>, Kumar Gala <galak@codeaurora.org>
Subject: RE: [PATCH 1/4] dt/bindings: Introduce the FSL QorIQ DPAA BMan
Date: Thu, 30 Oct 2014 15:10:18 +0000
Message-ID: <583a6b251a064011afbee7c64ca62cff@DM2PR03MB479.namprd03.prod.outlook.com>
References: <1413986972-621-1-git-send-email-Emilian.Medve@Freescale.com>
 <EA33D307-CCDA-4A30-9386-46FA832FE0CA@codeaurora.org>
 <1414519738.23458.84.camel__4795.38602890006$1414521743$gmane$org@snotra.buserror.net>
 <54515ECB.70404@Freescale.com>
In-Reply-To: <54515ECB.70404@Freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "mark.rutland@arm.com" <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "pawel.moll@arm.com" <pawel.moll@arm.com>,
 "ijc+devicetree@hellion.org.uk" <ijc+devicetree@hellion.org.uk>,
 Geoff Thorpe <Geoff.Thorpe@freescale.com>, "corbet@lwn.net" <corbet@lwn.net>,
 "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
 "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>, Rajan
 Srivastava <Rajan.Srivastava@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhwcGMtZGV2IFtt
YWlsdG86bGludXhwcGMtZGV2LQ0KPiBib3VuY2VzK3ZhcnVuLnNldGhpPWZyZWVzY2FsZS5jb21A
bGlzdHMub3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIEVtaWwNCj4gTWVkdmUNCj4gU2VudDogVGh1
cnNkYXksIE9jdG9iZXIgMzAsIDIwMTQgMzoxMCBBTQ0KPiBUbzogV29vZCBTY290dC1CMDc0MjE7
IEt1bWFyIEdhbGENCj4gQ2M6IG1hcmsucnV0bGFuZEBhcm0uY29tOyBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsNCj4gcGF3ZWwubW9sbEBhcm0uY29tOyBjb3JiZXRAbHduLm5ldDsgVGhvcnBl
IEdlb2ZmLVIwMTM2MTsNCj4gaWpjK2RldmljZXRyZWVAaGVsbGlvbi5vcmcudWs7IGxpbnV4LWRv
Y0B2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLQ0KPiBkZXZAb3psYWJzLm9yZzsgcm9iaCtkdEBr
ZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC9iaW5kaW5nczogSW50cm9k
dWNlIHRoZSBGU0wgUW9ySVEgRFBBQSBCTWFuDQo+IA0KPiBIZWxsbyBTY290dCwNCj4gDQo+IA0K
PiBPbiAxMC8yOC8yMDE0IDAxOjA4IFBNLCBTY290dCBXb29kIHdyb3RlOg0KPiA+IE9uIFR1ZSwg
MjAxNC0xMC0yOCBhdCAwOTozNiAtMDUwMCwgS3VtYXIgR2FsYSB3cm90ZToNCj4gPj4gT24gT2N0
IDIyLCAyMDE0LCBhdCA5OjA5IEFNLCBFbWlsIE1lZHZlIDxFbWlsaWFuLk1lZHZlQGZyZWVzY2Fs
ZS5jb20+DQo+IHdyb3RlOg0KPiA+Pg0KPiA+Pj4gVGhlIEJ1ZmZlciBNYW5hZ2VyIGlzIHBhcnQg
b2YgdGhlIERhdGEtUGF0aCBBY2NlbGVyYXRpb24gQXJjaGl0ZWN0dXJlDQo+IChEUEFBKS4NCj4g
Pj4+IEJNYW4gc3VwcG9ydHMgaGFyZHdhcmUgYWxsb2NhdGlvbiBhbmQgZGVhbGxvY2F0aW9uIG9m
IGJ1ZmZlcnMNCj4gPj4+IGJlbG9uZ2luZyB0byBwb29scyBvcmlnaW5hbGx5IGNyZWF0ZWQgYnkg
c29mdHdhcmUgd2l0aCBjb25maWd1cmFibGUNCj4gZGVwbGV0aW9uIHRocmVzaG9sZHMuDQo+ID4+
PiBUaGlzIGJpbmRpbmcgY292ZXJzIHRoZSBDQ1NSIHNwYWNlIHByb2dyYW1taW5nIG1vZGVsDQo+
ID4+Pg0KPiA+Pj4gU2lnbmVkLW9mZi1ieTogRW1pbCBNZWR2ZSA8RW1pbGlhbi5NZWR2ZUBGcmVl
c2NhbGUuY29tPg0KPiA+Pj4gQ2hhbmdlLUlkOiBJM2VjNDc5YmZiM2M5MTk1MWU5NjkwMmYwOTFm
NWQ3ZDJhZGJlZjNiMg0KPiA+Pj4gLS0tDQo+ID4+PiAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9w
b3dlcnBjL2ZzbC9ibWFuLnR4dCAgICAgICB8IDk4DQo+ICsrKysrKysrKysrKysrKysrKysrKysN
Cj4gPj4+IDEgZmlsZSBjaGFuZ2VkLCA5OCBpbnNlcnRpb25zKCspDQo+ID4+PiBjcmVhdGUgbW9k
ZSAxMDA2NDQNCj4gPj4+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wb3dlcnBj
L2ZzbC9ibWFuLnR4dA0KPiA+Pg0KPiA+PiBTaG91bGQgdGhlc2UgcmVhbGx5IGJlIGluIGJpbmRp
bmdzL3Bvd2VycGMvZnNsLCBhcmVu4oCZdCB5b3UgZ3V5cyB1c2luZyB0aGlzIG9uDQo+IEFSTSBT
b0NzIGFzIHdlbGw/DQo+ID4NCj4gPiBUaGUgaGFyZHdhcmUgb24gdGhlIEFSTSBTb0NzIGlzIGRp
ZmZlcmVudCBlbm91Z2ggdGhhdCBJJ20gbm90IHN1cmUgdGhlDQo+ID4gc2FtZSBiaW5kaW5nIHdp
bGwgY292ZXIgaXQuICBUaGF0IHNhaWQsIHB1dHRpbmcgdGhpbmdzIHVuZGVyIDxhcmNoPg0KPiA+
IHNob3VsZCBiZSBhIGxhc3QgcmVzb3J0IGlmIG5vd2hlcmUgZWxzZSBmaXRzLg0KPiANCj4gT1RD
IHN0YXJ0ZWQgcG9ydGVkIHRoZSBkcml2ZXIgdG8gdGhlIHRoZSBBUk0gU29DIGFuZCB0aGUgZmVl
ZGJhY2sgaGFzIGJlZW4NCj4gdGhhdCB0aGUgZHJpdmVyIG5lZWRlZCBtaW5pbWFsIGNoYW5nZXMu
IFRoZSBJT01NVSBoYXMgYmVlbiB0aGUgb25seSBhcmVhDQo+IG9mIGNvbmNlcm4sIGFuZCBhIHNt
YWxsIGNoYW5nZSB0byB0aGUgYmluZGluZyBoYXMgYmVlbiBzdWdnZXN0ZWQNCklPTU1VIHNwZWNp
ZmljIGJpbmRpbmcgd291bGQgYmUgZGlmZmVyZW50LiBUaGUgYmluZGluZyB3b3VsZCBoYXZlIHRv
IGNvbXBseSB0byB0aGUgYXJtLXNtbXUgYmluZGluZyAod2hpY2ggbmVlZHMgdG8gYmUgdXBkYXRl
ZCkuDQoNCi1WYXJ1bg0K
