Return-Path: <B29983@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E87652C0097
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Oct 2013 13:08:44 +1100 (EST)
From: Tang Yuantian-B29983 <B29983@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH v5] powerpc/mpc85xx: Update the clock nodes in device tree
Date: Thu, 17 Oct 2013 02:08:31 +0000
Message-ID: <D07C73A334FF604B95B3CBD2A545D07B150C4600@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1381300704-4238-1-git-send-email-Yuantian.Tang@freescale.com>
 <20131010100331.GE26954@e106331-lin.cambridge.arm.com>
 <D07C73A334FF604B95B3CBD2A545D07B150BD137@039-SN2MPN1-013.039d.mgd.msft.net>
 <20131011092526.GE3910@e106331-lin.cambridge.arm.com>
 <1381518433.7979.536.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C24BD@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381788786.7979.643.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C2B08@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381858855.7979.693.camel@snotra.buserror.net>
 <D07C73A334FF604B95B3CBD2A545D07B150C312F@039-SN2MPN1-013.039d.mgd.msft.net>
 <1381942009.7979.727.camel@snotra.buserror.net>
In-Reply-To: <1381942009.7979.727.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Mark Rutland <mark.rutland@arm.com>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Li Yang-Leo-R58472 <r58472@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiA+ID4gVGhhdCBzaG93cyB0aGUgZGl2aWRlcnMgYXMgYmVpbmcgc29tZXdoZXJlIGluIGJldHdl
ZW4gdGhlIFBMTCBhbmQgdGhlDQo+IE1VWC4NCj4gPiA+IFRoZSBNVVggaXMgd2hlcmUgdGhlIGRp
dmlkZXIgaXMgc2VsZWN0ZWQuICBUaGVyZSdzIG5vdGhpbmcgaW4gdGhlDQo+ID4gPiBQTEwncyBw
cm9ncmFtbWluZyBpbnRlcmZhY2UgdGhhdCByZWxhdGVzIHRvIHRoZSBkaXZpZGVycy4gIEFzIHN1
Y2gNCj4gPiA+IGl0J3Mgc2ltcGxlciB0byBtb2RlbCBpdCBhcyBiZWluZyBwYXJ0IG9mIHRoZSBN
VVguDQo+ID4gPg0KPiA+ID4gLVNjb3R0DQo+ID4gPg0KPiA+IEkgZG9uJ3Qga25vdyB3aGV0aGVy
IGl0IGlzIHNpbXBsZXIsIGJ1dCAibW9kZWxpbmcgZGl2aWRlciBhcyBiZWluZyBwYXJ0DQo+IG9m
IHRoZSBNVVgiDQo+ID4gaXMgeW91ciBndWVzcywgcmlnaHQ/DQo+ID4gSWYgdGhlICJkaXZpZGVy
IiBpcyBpbmNsdWRlZCBpbiBNVVgsIHRoZSBNVVggd291bGQgbm90IGJlIGNhbGxlZCAiTVVYIi4N
Cj4gDQo+IEl0J3Mgc3RpbGwgc2VsZWN0aW5nIGZyb20gbXVsdGlwbGUgUExMcy4NCj4gDQo+ID4g
SSBkb24ndCBrbm93IHdoZXRoZXIgImRpdmlkZXIiIG1vZHVsZSBleGlzdHMgb3Igbm90LiBJZiBp
dCBleGlzdHMsIGl0DQo+ID4gc2hvdWxkIGJlIHBhcnQgb2YgUExMIG9yIGJldHdlZW4gUExMIGFu
ZCBNVVguIHdoZXJldmVyIGl0IHdhcywgdGhlDQo+IGRldmljZSB0cmVlIGJpbmRpbmcgaXMgYXBw
cm9wcmlhdGUuDQo+IA0KPiBUaGUgZGV2aWNlIHRyZWUgYmluZGluZyBpcyB1bm5lY2Vzc2FyaWx5
IGNvbXBsaWNhdGVkLg0KPiANCj4gPiBUaGUgUDMwNDFSTSBzaG93cyBleGFjdGx5IGVhY2ggUExM
IGhhcyAyIG91dHB1dHMgd2hpY2ggZGVmaW5pdGVseSBoYXZlDQo+IG5vICJkaXZpZGVyIiBhdCBh
bGwuDQo+IA0KPiBUaGF0IGRpYWdyYW0gaXMgYSBiaXQgd2VpcmQgLS0gb25lIG9mIHRoZSBvdXRw
dXRzIGlzIHVzZWQgYXMgaXMsIGFuZCB0aGUNCj4gb3RoZXIgaXMgc3BsaXQgaW50byAxLzIgYW5k
IDEvNC4gIEl0IGRvZXNuJ3QgcmVhbGx5IG1hdHRlciB0aG91Z2g7IHRoZQ0KPiBlbmQgcmVzdWx0
IGlzIHRoZSBzYW1lLiAgV2UncmUgZGVzY3JpYmluZyB0aGUgcHJvZ3JhbW1pbmcgaW50ZXJmYWNl
LCBub3QNCj4gYXJ0d29yayBjaG9pY2VzIGluIHRoZSBtYW51YWwuDQo+IA0KPiAtU2NvdHQNCj4g
DQpJZiB0aGUgZGV2aWNlIHRyZWUgbmVlZHMgdG8gYmUgbW9kaWZpZWQsIGNvdWxkIHlvdSBnaXZl
IG1lIHlvdXIgc3VnZ2VzdGlvbnM/DQoNClJlZ2FyZHMsDQpZdWFudGlhbg0K
