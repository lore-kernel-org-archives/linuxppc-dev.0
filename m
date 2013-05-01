Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 030F42C00A3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 May 2013 02:02:22 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02444-04 for <linuxppc-dev@lists.ozlabs.org>;
 Wed,  1 May 2013 16:55:36 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Subject: RE: [PATCH v2 net-next] af_unix: fix a fatal race with bit fields
Date: Wed, 1 May 2013 16:53:48 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B721C@saturn3.aculab.com>
In-Reply-To: <1367421843.11020.43.camel@edumazet-glaptop>
References: <1367370761.11020.22.camel@edumazet-glaptop>
 <1367372393.22115.6.camel@pasglop>
 <20130501.033650.703182794549888825.davem@davemloft.net>
 <1367421843.11020.43.camel@edumazet-glaptop>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Eric Dumazet" <eric.dumazet@gmail.com>,
 "David Miller" <davem@davemloft.net>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org, ambrose@google.com,
 netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9uZXQvYWZfdW5peC5oIGIvaW5jbHVkZS9uZXQvYWZfdW5p
eC5oDQo+IGluZGV4IGE4ODM2ZTguLmRiZGZkMmIgMTAwNjQ0DQo+IC0tLSBhL2luY2x1ZGUvbmV0
L2FmX3VuaXguaA0KPiArKysgYi9pbmNsdWRlL25ldC9hZl91bml4LmgNCj4gQEAgLTU3LDkgKzU3
LDEwIEBAIHN0cnVjdCB1bml4X3NvY2sgew0KPiAgCXN0cnVjdCBsaXN0X2hlYWQJbGluazsNCj4g
IAlhdG9taWNfbG9uZ190CQlpbmZsaWdodDsNCj4gIAlzcGlubG9ja190CQlsb2NrOw0KPiAtCXVu
c2lnbmVkIGludAkJZ2NfY2FuZGlkYXRlIDogMTsNCj4gLQl1bnNpZ25lZCBpbnQJCWdjX21heWJl
X2N5Y2xlIDogMTsNCj4gIAl1bnNpZ25lZCBjaGFyCQlyZWN1cnNpb25fbGV2ZWw7DQo+ICsJdW5z
aWduZWQgbG9uZwkJZ2NfZmxhZ3M7DQo+ICsjZGVmaW5lIFVOSVhfR0NfQ0FORElEQVRFCTANCj4g
KyNkZWZpbmUgVU5JWF9HQ19NQVlCRV9DWUNMRQkxDQo+ICAJc3RydWN0IHNvY2tldF93cQlwZWVy
X3dxOw0KPiAgfTsNCg0KV2h5IG5vdCBqdXN0IGNoYW5nZSBnY19jYW5kaWRhdGUgYW5kIGdjX21h
eWJlX2N5Y2xlIHRvDQp1bnNpZ25lZCBjaGFyPw0KSXQgbWlnaHQgcmVkdWNlIHRoZSBudW1iZXIg
b2YgcGFkIGJ5dGVzIHNvbWV3aGF0Lg0KDQoJRGF2aWQNCg0K
