Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0145.outbound.protection.outlook.com [207.46.100.145])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BDF0D1A035C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Sep 2015 12:30:17 +1000 (AEST)
From: Wang Dongsheng <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "robh+dt@kernel.org" <robh+dt@kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>, Huan Wang
 <alison.wang@freescale.com>, Jin Jason <Jason.Jin@freescale.com>, Zhao C.H.
 <chenhui.zhao@freescale.com>, Yuantian Tang <Yuantian.Tang@freescale.com>
Subject: RE: [PATCH v2 1/2] fsl: Add binding for RCPM
Date: Wed, 16 Sep 2015 02:30:09 +0000
Message-ID: <SN1PR0301MB161688E3AF527ADC76AB2B8F9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
References: <1442307339-15225-1-git-send-email-dongsheng.wang@freescale.com>
 <1442361398.2909.164.camel@freescale.com>
 <SN1PR0301MB1616C48FB3D990BCA45289AB9D5B0@SN1PR0301MB1616.namprd03.prod.outlook.com>
 <1442369955.2909.166.camel@freescale.com>
In-Reply-To: <1442369955.2909.166.camel@freescale.com>
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

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTUgMTA6MTkg
QU0NCj4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiBDYzogZGV2aWNldHJlZUB2Z2VyLmtl
cm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOw0KPiByb2JoK2R0QGtlcm5l
bC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsgV2FuZyBIdWFuLUIx
ODk2NTsgSmluDQo+IFpoZW5neGlvbmctUjY0MTg4OyBaaGFvIENoZW5odWktQjM1MzM2OyBUYW5n
IFl1YW50aWFuLUIyOTk4Mw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gZnNsOiBBZGQg
YmluZGluZyBmb3IgUkNQTQ0KPiANCj4gT24gVHVlLCAyMDE1LTA5LTE1IGF0IDIxOjE1IC0wNTAw
LCBXYW5nIERvbmdzaGVuZy1CNDA1MzQgd3JvdGU6DQo+ID4gSGkgU2NvdHQsDQo+ID4NCj4gPiA+
IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQy
MQ0KPiA+ID4gU2VudDogV2VkbmVzZGF5LCBTZXB0ZW1iZXIgMTYsIDIwMTUgNzo1NyBBTQ0KPiA+
ID4gVG86IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNA0KPiA+ID4gQ2M6IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsNCj4gPiA+IHJvYmgrZHRA
a2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOyBXYW5nIEh1
YW4tDQo+ID4gPiBCMTg5NjU7IEppbg0KPiA+ID4gWmhlbmd4aW9uZy1SNjQxODg7IFpoYW8gQ2hl
bmh1aS1CMzUzMzY7IFRhbmcgWXVhbnRpYW4tQjI5OTgzDQo+ID4gPiBTdWJqZWN0OiBSZTogW1BB
VENIIHYyIDEvMl0gZnNsOiBBZGQgYmluZGluZyBmb3IgUkNQTQ0KPiA+ID4NCj4gPiA+IE9uIFR1
ZSwgMjAxNS0wOS0xNSBhdCAxNjo1NSArMDgwMCwgRG9uZ3NoZW5nIFdhbmcgd3JvdGU6DQo+ID4g
PiA+ICsqIEZyZWVzY2FsZSBSQ1BNIFdha2V1cCBTb3VyY2UgRGV2aWNlIFRyZWUgQmluZGluZ3MN
Cj4gPiA+ID4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0NCj4g
PiA+ID4gK1JlcXVpcmVkIHJjcG0td2FrZXVwIHByb3BlcnR5IHNob3VsZCBiZSBhZGRlZCB0byBh
IGRldmljZSBub2RlIGlmDQo+ID4gPiA+ICt0aGUNCj4gPiA+ID4gZGV2aWNlDQo+ID4gPiA+ICtj
YW4gYmUgdXNlZCBhcyBhIHdha2V1cCBzb3VyY2UuDQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgLSBy
Y3BtLXdha2V1cDogVGhlIHZhbHVlIG9mIHRoZSBwcm9wZXJ0eSBjb25zaXN0cyBvZiAzIGNlbGxz
Lg0KPiA+ID4gPiArIFRoZQ0KPiA+ID4gPiBmaXJzdA0KPiA+ID4gPiBjZWxsDQo+ID4gPiA+ICsg
ICAgIGlzIGEgcG9pbnRlciB0byB0aGUgcmNwbSBub2RlLCB0aGUgc2Vjb25kIGNlbGwgaXMgdGhl
IGJpdA0KPiA+ID4gPiArIG1hc2sNCj4gPiA+ID4gdGhhdA0KPiA+ID4gPiArICAgICBzaG91bGQg
YmUgc2V0IGluIElQUERFWFBDUjAsIGFuZCB0aGUgbGFzdCBjZWxsIGlzIGZvciBJUFBERVhQQ1Ix
Lg0KPiA+ID4gPiArICAgICBOb3RlOiBJZiB0aGUgcGxhdGZvcm0gaGFzIG5vIElQUERFWFBDUjEg
cmVnaXN0ZXIsIHB1dCBhIHplcm8gaGVyZS4NCj4gPiA+DQo+ID4gPiBXaGF0IGlmIGEgZnV0dXJl
IHBsYXRmb3JtIGhhcyBtb3JlIHRoYW4gdHdvIG9mIHRoZXNlIHJlZ2lzdGVycz8NCj4gPg0KPiA+
IFRob3NlIHJlZ2lzdGVycyBhcmUgb25seSB1c2VkIGZvciB3YWtldXAgZGV2aWNlLCB3ZSBoYXZl
IGEgbG90IG9mDQo+ID4gYXZhaWxhYmxlIGJpdCBmb3IgZmVhdHVyZS4gRm9yIGV4YW1wbGUsIElu
IExTMTAyMWEgcGxhdGZvcm0gb25seSA3Yml0cw0KPiA+IGhhcyB1c2VkIGluIHRoZSByZWdpc3Rl
cnMsIGFuZCA1N2JpdHMgaXMgcmVzZXJ2ZWQuDQo+IA0KPiBTdGlsbCwgaXQnZCBiZSBiZXR0ZXIg
dG8gZm9yIHRoZSByY3BtIG5vZGUgdG8gYWR2ZXJ0aXNlIHRoZSBudW1iZXIgb2YgY2VsbHMgaXQN
Cj4gZXhwZWN0cy4NCg0KRm9yIHRoZSBmb3Jlc2VlYWJsZSBmdXR1cmUgaXQgc2hvdWxkIGJlIGVu
b3VnaCB0byB1c2UsIGV2ZW4gaWYgbm90IGVub3VnaCB0byB1c2UgaW4NCnRoZSBmdXR1cmUgYXQg
dGhhdCB0aW1lIHdlIGNhbiB1cGRhdGUgdGhlIGJpbmRpbmcuDQoNClJlZ2FyZHMsDQotRG9uZ3No
ZW5nDQo=
