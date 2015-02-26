Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0118.outbound.protection.outlook.com [157.56.110.118])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2480E1A002B
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 19:27:09 +1100 (AEDT)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH] powerpc/fsl: add power_off support for fsl platform
Date: Thu, 26 Feb 2015 07:54:23 +0000
Message-ID: <BN1PR03MB188835F69D2051202ABE1439D140@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1423032421-31561-1-git-send-email-dongsheng.wang@freescale.com>
 <1424831385.4698.53.camel@freescale.com>
In-Reply-To: <1424831385.4698.53.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Hongtao Jia <hongtao.jia@freescale.com>,
 "Jason.Jin@freescale.com" <Jason.Jin@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyNSwgMjAxNSAxMDozMCBBTQ0KPiBUbzog
V2FuZyBEb25nc2hlbmctQjQwNTM0DQo+IENjOiBKaW4gWmhlbmd4aW9uZy1SNjQxODg7IExpIFlh
bmctTGVvLVI1ODQ3MjsgSmlhIEhvbmd0YW8tQjM4OTUxOyBsaW51eHBwYy0NCj4gZGV2QGxpc3Rz
Lm96bGFicy5vcmcNCj4gU3ViamVjdDogUmU6IFtQQVRDSF0gcG93ZXJwYy9mc2w6IGFkZCBwb3dl
cl9vZmYgc3VwcG9ydCBmb3IgZnNsIHBsYXRmb3JtDQo+IA0KPiBPbiBXZWQsIDIwMTUtMDItMDQg
YXQgMTQ6NDcgKzA4MDAsIERvbmdzaGVuZyBXYW5nIHdyb3RlOg0KPiA+ICt2b2lkIHBwY19tZF9m
aXh1cCh2b2lkKQ0KPiA+ICt7DQo+IA0KPiBUaGlzIG5hbWUgaXMgd2F5IHRvbyBnZW5lcmljICh0
aG91Z2ggaXQncyBtb290IHNpbmNlIHlvdSBzaG91bGRuJ3QgdXNlIHBwY19tZA0KPiBmb3IgdGhp
cykuDQo+IA0KDQpBZ3JlZS4NCg0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpucDsNCj4gPiAr
DQo+ID4gKwlucCA9IG9mX2ZpbmRfY29tcGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsICJmc2wsZnBn
YS1xaXhpcyIpOw0KPiA+ICsJaWYgKCFucCkNCj4gPiArCQlyZXR1cm47DQo+ID4gKw0KPiA+ICsJ
b2Zfbm9kZV9wdXQobnApOw0KPiA+ICsNCj4gPiArCXBtX3Bvd2VyX29mZiA9IGZzbF9wb3dlcl9v
ZmY7DQo+ID4gKwlwcGNfbWQuaGFsdCA9IGZzbF9wb3dlcl9vZmY7DQo+ID4gK30NCj4gDQo+IFBs
ZWFzZSBpbXBsZW1lbnQgdGhpcyBhcyBhIGRyaXZlcnMvcG93ZXIvcmVzZXQgZHJpdmVyLCBhbmQg
Y29uc2lkZXIgYmFzaW5nIG9uDQo+IHRvcCBvZiBodHRwOi8vbGlzdHMuaW5mcmFkZWFkLm9yZy9w
aXBlcm1haWwvbGludXgtYXJtLWtlcm5lbC8yMDE0LQ0KPiBPY3RvYmVyLzI5MzA4OS5odG1sDQo+
IA0KDQpUaGFua3MuDQoNClJlZ2FyZHMsDQotRG9uZ3NoZW5nDQo=
