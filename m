Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by ozlabs.org (Postfix) with SMTP id 09A092C0079
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Jun 2013 02:28:15 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 02987-10 for <linuxppc-dev@lists.ozlabs.org>;
 Mon, 24 Jun 2013 17:28:10 +0100 (BST)
MIME-Version: 1.0
Content-Type: text/plain;
	charset="UTF-8"
Subject: RE: [PATCH] Correct build warnings with CONFIG_TRANSPARENT_HUGEPAGE
 disabled
Date: Mon, 24 Jun 2013 17:27:13 +0100
Message-ID: <AE90C24D6B3A694183C094C60CF0A2F6026B72A4@saturn3.aculab.com>
In-Reply-To: <87ehbrzfsc.fsf@linux.vnet.ibm.com>
References: <51C8594B.1080701@linux.vnet.ibm.com>
 <87hagnzgzk.fsf@linux.vnet.ibm.com> <87ehbrzfsc.fsf@linux.vnet.ibm.com>
From: "David Laight" <David.Laight@ACULAB.COM>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "Nathan Fontenot" <nfont@linux.vnet.ibm.com>,
 <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

PiBmYWlsdXJlOg0KPiBfX19fX19fX19fDQo+IHN0YXRpYyBpbmxpbmUgX19hdHRyaWJ1dGVfXygo
YWx3YXlzX2lubGluZSkpIF9fYXR0cmlidXRlX18oKG5vX2luc3RydW1lbnRfZnVuY3Rpb24pKSBp
bnQNCj4gX19oYXNoX3BhZ2VfdGhwKHVuc2lnbmVkIGxvbmcgZWEsIHVuc2lnbmVkIGxvbmcgYWNj
ZXNzLA0KPiAgICAgICB1bnNpZ25lZCBsb25nIHZzaWQsIHBtZF90ICpwbWRwLA0KPiAgICAgICB1
bnNpZ25lZCBsb25nIHRyYXAsIGludCBsb2NhbCwNCj4gICAgICAgaW50IHNzaXplLCB1bnNpZ25l
ZCBpbnQgcHNpemUpDQo+IHsNCj4gIGRvIHsgX19hc21fXyBfX3ZvbGF0aWxlX18oICIxOiB0d2kg
MzEsMCwwXG4iICIuc2VjdGlvbiBfX2J1Z190YWJsZSxcImFcIlxuIiAiMjpcdCIgIi5sbG9uZyIg
IiAiICIxYiwNCj4gJTBcbiIgIlx0LnNob3J0ICUxLCAlMlxuIiAiLm9yZyAyYislM1xuIiAiLnBy
ZXZpb3VzXG4iIDogOiAiaSINCj4gKCIvaG9tZS9uZm9udC9zcmMvcG93ZXJwYy9hcmNoL3Bvd2Vy
cGMvaW5jbHVkZS9hc20vbW11LWhhc2g2NC5oIiksICJpIiAoMzUzKSwgImkiICgwKSwgImkiDQo+
IChzaXplb2Yoc3RydWN0IGJ1Z19lbnRyeSkpKTsgZG8geyB9IHdoaWxlICgxKTsgfSB3aGlsZSAo
MCk7DQo+IH0NCg0KV2h5IGlzbid0IHRoZSAiZG8geyB9IHdoaWxlICgxKTsiIGVub3VnaCB0byBz
dG9wIHRoZSBjb21waWxlcg0KZXhwZWN0aW5nIHRoZSBhYm92ZSB0byByZXR1cm4/DQpJIGtub3cg
SSd2ZSBhZGRlZCAiZm9yICg7Oyk7IiBpbiBzb21lIGNvZGUgYmVmb3JlIG5vdy4NCkRpc2FibGlu
ZyBvcHRpbWlzYXRpb25zIHdvdWxkIGJlIGVub3VnaCAtIGJ1dCB1bmxpa2VseSB0byBiZSB0cnVl
Lg0KDQoJRGF2aWQNCg0K
