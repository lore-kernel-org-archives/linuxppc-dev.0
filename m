Return-Path: <Jianhua.Xie@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0113.outbound.protection.outlook.com [65.55.169.113])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6BAB11A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:32:57 +1000 (AEST)
From: Jianhua Xie <Jianhua.Xie@freescale.com>
To: Madalin-Cristian Bucur <madalin.bucur@freescale.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [RFC,v3 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Wed, 10 Jun 2015 06:00:17 +0000
Message-ID: <DM2PR0301MB086380B3D89425345562F384F3BD0@DM2PR0301MB0863.namprd03.prod.outlook.com>
References: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
In-Reply-To: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTGludXhwcGMtZGV2IFtt
YWlsdG86bGludXhwcGMtZGV2LQ0KPiBib3VuY2VzK2ppYW5odWEueGllPWZyZWVzY2FsZS5jb21A
bGlzdHMub3psYWJzLm9yZ10gT24gQmVoYWxmIE9mIE1hZGFsaW4NCj4gQnVjdXINCj4gU2VudDog
V2VkbmVzZGF5LCBBcHJpbCAyOSwgMjAxNSAxMDo1NyBQTQ0KPiBUbzogbmV0ZGV2QHZnZXIua2Vy
bmVsLm9yZzsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gQ2M6IGxpbnV4LWtlcm5l
bEB2Z2VyLmtlcm5lbC5vcmc7IEJ1Y3VyIE1hZGFsaW4tQ3Jpc3RpYW4tQjMyNzE2DQo+IFN1Ympl
Y3Q6IFtSRkMsdjMgMDIvMTBdIGRwYWFfZXRoOiBhZGQgc3VwcG9ydCBmb3IgRFBBQSBFdGhlcm5l
dA0KPiANCj4gVGhpcyBpbnRyb2R1Y2VzIHRoZSBGcmVlc2NhbGUgRGF0YSBQYXRoIEFjY2VsZXJh
dGlvbiBBcmNoaXRlY3R1cmUNCj4gKERQQUEpIEV0aGVybmV0IGRyaXZlciAoZHBhYV9ldGgpIHRo
YXQgYnVpbGRzIHVwb24gdGhlIERQQUEgUU1hbiwNCj4gQk1hbiwgUEFNVSBhbmQgRk1hbiBkcml2
ZXJzIHRvIGRlbGl2ZXIgRXRoZXJuZXQgY29ubmVjdGl2aXR5IG9uDQo+IHRoZSBGcmVlc2NhbGUg
RFBBQSBRb3JJUSBwbGF0Zm9ybXMuDQo+IA0KU25pcC4uLi4uLg0KDQo+ICsNCj4gKwlpZiAodW5s
aWtlbHkoZHBhX3htaXQocHJpdiwgcGVyY3B1X3N0YXRzLCBxdWV1ZV9tYXBwaW5nLCAmZmQpIDwg
MCkpDQo+ICsJCWdvdG8geG1pdF9mYWlsZWQ7DQo+ICsNCj4gKwluZXRfZGV2LT50cmFuc19zdGFy
dCA9IGppZmZpZXM7DQoNCkl0IGlzIHByb2JhYmx5IGJldHRlciB0byB1c2UgbmV0ZGV2X3F1ZXVl
LT50cmFuc19zdGFydCB0byBpbnN0ZWFkIG9mIG5ldF9kZXYtPnRyYW5zX3N0YXJ0IG9uIFNNUC4N
Cg0KQmVzdCBSZWdhcmRzLA0KSmlhbmh1YQ0KDQo+ICsJcmV0dXJuIE5FVERFVl9UWF9PSzsNCj4g
Kw0KPiAreG1pdF9mYWlsZWQ6DQo+ICsJaWYgKGZkLmNtZCAmIEZNX0ZEX0NNRF9GQ08pIHsNCj4g
KwkJKCpjb3VudHB0ciktLTsNCj4gKwkJZHBhX2ZkX3JlbGVhc2UobmV0X2RldiwgJmZkKTsNCj4g
KwkJcGVyY3B1X3N0YXRzLT50eF9lcnJvcnMrKzsNCj4gKwkJcmV0dXJuIE5FVERFVl9UWF9PSzsN
Cj4gKwl9DQo+ICsJX2RwYV9jbGVhbnVwX3R4X2ZkKHByaXYsICZmZCk7DQo+ICsJcGVyY3B1X3N0
YXRzLT50eF9lcnJvcnMrKzsNCj4gKwlkZXZfa2ZyZWVfc2tiKHNrYik7DQo+ICsJcmV0dXJuIE5F
VERFVl9UWF9PSzsNCj4gK30NCj4gLS0NCj4gMS43LjExLjcNCj4gDQo+IF9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fDQo+IExpbnV4cHBjLWRldiBtYWlsaW5n
IGxpc3QNCj4gTGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmcNCj4gaHR0cHM6Ly9saXN0cy5v
emxhYnMub3JnL2xpc3RpbmZvL2xpbnV4cHBjLWRldg0K
