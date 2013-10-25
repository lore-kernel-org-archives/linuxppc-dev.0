Return-Path: <r63061@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe005.messaging.microsoft.com [213.199.154.208])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 943D92C012D
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 20:50:07 +1100 (EST)
Received: from mail84-am1 (localhost [127.0.0.1])	by mail84-am1-R.bigfish.com
 (Postfix) with ESMTP id 1435E480232	for
 <linuxppc-dev@lists.ozlabs.org>; Fri,
 25 Oct 2013 09:50:00 +0000 (UTC)
Received: from AM1EHSMHS017.bigfish.com (unknown [10.3.201.248])	by
 mail84-am1.bigfish.com (Postfix) with ESMTP id 69BE43A0067	for
 <linuxppc-dev@lists.ozlabs.org>; Fri, 25 Oct 2013 09:49:57 +0000 (UTC)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
Date: Fri, 25 Oct 2013 09:49:51 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D6264C9@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380301430.24959.399.camel@snotra.buserror.net>
In-Reply-To: <1380301430.24959.399.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Johnston Michael-R49610 <r49610@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogU2F0dXJkYXksIFNlcHRlbWJlciAyOCwgMjAxMyAxOjA0IEFN
DQo+IFRvOiBYaWUgWGlhb2JvLVI2MzA2MQ0KPiBDYzogV29vZCBTY290dC1CMDc0MjE7IGxpbnV4
cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBKb2huc3RvbiBNaWNoYWVsLQ0KPiBSNDk2MTANCj4g
U3ViamVjdDogUmU6IFtQQVRDSCBWNCAzLzNdIHBvd2VycGMvODV4eDogQWRkIFRXUi1QMTAyNSBi
b2FyZCBzdXBwb3J0DQo+IA0KPiBPbiBXZWQsIDIwMTMtMDktMjUgYXQgMDQ6NTAgLTA1MDAsIFhp
ZSBYaWFvYm8tUjYzMDYxIHdyb3RlOg0KPiA+ID4gPiArI2lmIGRlZmluZWQoQ09ORklHX1NFUklB
TF9RRSkNCj4gPiA+ID4gKwkJCS8qIE9uIFAxMDI1VFdSIGJvYXJkLCB0aGUgVUNDNyBhY3RlZCBh
cyBVQVJUIHBvcnQuDQo+ID4gPiA+ICsJCQkgKiBIb3dldmVyLCBUaGUgVUNDNydzIENUUyBwaW4g
aXMgbG93IGxldmVsIGluDQo+IGRlZmF1bHQsDQo+ID4gPiA+ICsJCQkgKiBpdCB3aWxsIGltcGFj
dCB0aGUgdHJhbnNtaXNzaW9uIGluIGZ1bGwgZHVwbGV4DQo+ID4gPiA+ICsJCQkgKiBjb21tdW5p
Y2F0aW9uLiBTbyBkaXNhYmxlIHRoZSBGbG93IGNvbnRyb2wgcGluDQo+IFBBMTguDQo+ID4gPiA+
ICsJCQkgKiBUaGUgVUNDNyBVQVJUIGp1c3QgY2FuIHVzZSBSWEQgYW5kIFRYRCBwaW5zLg0KPiA+
ID4gPiArCQkJICovDQo+ID4gPiA+ICsJCQlwYXJfaW9fY29uZmlnX3BpbigwLCAxOCwgMCwgMCwg
MCwgMCk7ICNlbmRpZg0KPiA+ID4NCj4gPiA+IEFueSByZWFzb24gbm90IHRvIGRvIHRoaXMgdW5j
b25kaXRpb25hbGx5Pw0KPiA+DQo+ID4gVGhpcyBpcyBhIGJvYXJkIGlzc3VlLCB0aGUgY29kZSBh
bHJlYWR5IGhhdmUgYSBjb25kaXRpb24gLSBkZWZpbmVkDQo+ID4gU0VSSUFMX1FFLCBhbmQgSSB3
aWxsIGFkZCBhIGNvbmRpdGlvbiAiaWYgKG1hY2hpbmVfaXModHdyX3AxMDI1KSkiLg0KPiANCj4g
TXkgcG9pbnQgd2FzLCBpcyB0aGVyZSBhbnkgaGFybSBpbiBkb2luZyB0aGlzIHdpdGhvdXQgcmVn
YXJkIHRvDQo+IENPTkZJR19TRVJJQUxfUUU/DQoNClRoZSBDVFMgcGluIHdpbGwgYmUgdGhlIHBp
biBvZiBwcm9maWJ1cyBpZiBhZGQgYSBwcm9maWJ1cyBleHBhbnNpb24gYm9hcmQgaW4gVFdSIHN5
c3RlbS4gSWYgZGlzYWJsZSB0aGUgcGluIHVuY29uZGl0aW9uYWxseSwgaXQgd2lsbCBhZmZlY3Qg
dGhlIGZ1bmN0aW9uIG9mIHByb2ZpYnVzLiAgDQoNCi1YaWUgWGlhb2JvDQo+IA0KPiAtU2NvdHQN
Cj4gDQoNCg==
