Return-Path: <Shaohui.Xie@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5BD931A00A5
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  4 Jan 2015 15:59:01 +1100 (AEDT)
From: Shaohui Xie <Shaohui.Xie@freescale.com>
To: Emilian Medve <Emilian.Medve@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Scott Wood
 <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] powerpc/config: enable mdio buses muxing via
 Memory-mapped device
Date: Sun, 4 Jan 2015 04:58:53 +0000
Message-ID: <DM2PR0301MB0864469C4DF54A6592E7AA51E25B0@DM2PR0301MB0864.namprd03.prod.outlook.com>
References: <1419240062-29559-1-git-send-email-shh.xie@gmail.com>
 <54A65A09.6070705@Freescale.com>
In-Reply-To: <54A65A09.6070705@Freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Andy Fleming <afleming@gmail.com>, Shruti Kanetkar <Shruti@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGVsbG8gRW1pbCwNCg0KVGhlIHBhdGNoZXMgc2VudCBieSBTaHJ1dGkgd2VyZSBtYXJrZWQgYXMg
IkNoYW5nZXMgUmVxdWVzdGVkIiBvdmVyIDUgbW9udGhzLg0KdG8gbWUgaWYgdGhlIHBhdGNoZXMg
ZG8gbmVlZCBjaGFuZ2VzLCB0aGUgcG9zc2libGUgY2hhbmdlcyBzZWVtcyBub3QgaW4gJ2NvbmZp
ZycgYnV0IGluIGNvcmVuZXRfZ2VuZXJpYy5jLg0KSSdtIG5vdCBzdXJlIGlmIGl0J3MgT0sgdG8g
YWRkIHNvbWUgY29tcGF0aWJsZXMgaW4gY29yZW5ldF9nZW5lcmljLmMuIGlmIHdlIGNhbiB1c2Ug
dGhlIGV4aXN0aW5nIGNvbXBhdGlibGUgInNpbXBsZS1idXMiLA0KVGhlbiB3ZSB3aWxsIG9ubHkg
bmVlZCB0byBlbmFibGUgTURJTyBtdXggb3B0aW9uIGluIGNvbmZpZyB3aXRob3V0IGFkZGluZyBj
b21wYXRpYmxlIGluIGNvcmVuZXRfZ2VuZXJpYy5jLg0KDQpCZXN0IFJlZ2FyZHMsIA0KU2hhb2h1
aSBYaWUNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFbWlsIE1lZHZl
IFttYWlsdG86RW1pbGlhbi5NZWR2ZUBGcmVlc2NhbGUuY29tXQ0KPiBTZW50OiBGcmlkYXksIEph
bnVhcnkgMDIsIDIwMTUgNDo0MyBQTQ0KPiBUbzogc2hoLnhpZUBnbWFpbC5jb207IGxpbnV4cHBj
LWRldkBsaXN0cy5vemxhYnMub3JnOyBXb29kIFNjb3R0LUIwNzQyMQ0KPiBDYzogQW5keSBGbGVt
aW5nOyBYaWUgU2hhb2h1aS1CMjE5ODk7IEthbmV0a2FyIFNocnV0aS1CNDQ0NTQNCj4gU3ViamVj
dDogUmU6IFtQQVRDSCAyLzJdIHBvd2VycGMvY29uZmlnOiBlbmFibGUgbWRpbyBidXNlcyBtdXhp
bmcgdmlhDQo+IE1lbW9yeS1tYXBwZWQgZGV2aWNlDQo+IA0KPiBIZWxsbyBTaGFvLUh1aSwNCj4g
DQo+IA0KPiBPbiAxMi8yMi8yMDE0IDAzOjIxIEFNLCBzaGgueGllQGdtYWlsLmNvbSB3cm90ZToN
Cj4gPiBGcm9tOiBBbmR5IEZsZW1pbmcgPGFmbGVtaW5nQGdtYWlsLmNvbT4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEFuZHkgRmxlbWluZyA8YWZsZW1pbmdAZ21haWwuY29tPg0KPiA+IFNpZ25l
ZC1vZmYtYnk6IFNoYW9odWkgWGllIDxTaGFvaHVpLlhpZUBmcmVlc2NhbGUuY29tPg0KPiA+IC0t
LQ0KPiA+ICBhcmNoL3Bvd2VycGMvY29uZmlncy9jb3JlbmV0MzJfc21wX2RlZmNvbmZpZyB8IDEg
Kw0KPiA+IGFyY2gvcG93ZXJwYy9jb25maWdzL2NvcmVuZXQ2NF9zbXBfZGVmY29uZmlnIHwgMSAr
DQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspDQo+IA0KPiBTaHJ1dGkgc3Vi
bWl0dGVkIGEgbW9yZSBjb21wbGV0ZSB2ZXJzaW9uIG9mIHRoaXMgcGF0Y2ggaGVyZToNCj4gDQo+
IGh0dHA6Ly9wYXRjaHdvcmsub3psYWJzLm9yZy9wYXRjaC8zNzA4NzMNCj4gDQo+IFdlIHNob3Vs
ZCBzdGljayB3aXRoIHRoYXQgdmVyc2lvbg0KPiANCj4gDQo+IENoZWVycywNCg==
