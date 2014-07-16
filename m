Return-Path: <David.Laight@ACULAB.COM>
Received: from mx0.aculab.com (mx0.aculab.com [213.249.233.131])
 by lists.ozlabs.org (Postfix) with SMTP id 81BF71A01E1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Jul 2014 18:31:53 +1000 (EST)
Received: from mx0.aculab.com ([127.0.0.1])
 by localhost (mx0.aculab.com [127.0.0.1]) (amavisd-new, port 10024) with SMTP
 id 29806-07 for <linuxppc-dev@lists.ozlabs.org>;
 Wed, 16 Jul 2014 09:31:43 +0100 (BST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Gavin Shan' <gwshan@linux.vnet.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH 3/6] powerpc/eeh: Reduce lines of log dump
Date: Wed, 16 Jul 2014 08:30:55 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D17274752@AcuExch.aculab.com>
References: <1405489819-26211-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1405489819-26211-4-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405489819-26211-4-git-send-email-gwshan@linux.vnet.ibm.com>
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

RnJvbTogR2F2aW4gU2hhbg0KPiBUaGUgcGF0Y2ggcHJpbnRzIDQgUENJRSBvciBBRVIgY29uZmln
IHJlZ2lzdGVycyBlYWNoIGxpbmUsIHdoaWNoDQo+IGlzIHBhcnQgb2YgdGhlIEVFSCBsb2cgc28g
dGhhdCBpdCBsb29rcyBhIGJpdCBtb3JlIGNvbXBhY3QuDQouLi4NCj4gLQkJZm9yIChpPTA7IGk8
PTg7IGkrKykgew0KPiArCQlmb3IgKGk9MCwgaj0wOyBpPD04OyBpKyspIHsNCj4gIAkJCWVlaF9v
cHMtPnJlYWRfY29uZmlnKGRuLCBjYXArNCppLCA0LCAmY2ZnKTsNCj4gIAkJCW4gKz0gc2NucHJp
bnRmKGJ1ZituLCBsZW4tbiwgIiUwMng6JXhcbiIsIDQqaSwgY2ZnKTsNCj4gLQkJCXByX3dhcm4o
IkVFSDogUENJLUUgJTAyeDogJTA4eFxuIiwgaSwgY2ZnKTsNCj4gKw0KPiArCQkJaWYgKChpICUg
NCkgPT0gMCkgew0KPiArCQkJCW1lbXNldChidWZmZXIsIDAsIHNpemVvZihidWZmZXIpKTsNCg0K
WW91IGRvbid0IG5lZWQgYSBtZW1zZXQoKS4NCkkgd291bGQgYWRkOg0KCQkJCWlmIChpICE9IDAp
DQoJCQkJCXByX3dhcm4oIiVzXG4iLCBidWZmZXIpOw0KYW5kIG1vdmUgdGhlIG90aGVyIHByX3dh
cm4oKSBvdXRzaWRlIHRoZSBsb29wLg0KDQo+ICsJCQkJaiA9IHNjbnByaW50ZihidWZmZXIsIHNp
emVvZihidWZmZXIpLA0KPiArCQkJCQkgICAgICAiRUVIOiBQQ0ktRSAlMDJ4OiAlMDh4ICIsDQo+
ICsJCQkJCSAgICAgIDQqaSwgY2ZnKTsNCj4gKwkJCX0gZWxzZSB7DQo+ICsJCQkJaiArPSBzY25w
cmludGYoYnVmZmVyK2osIHNpemVvZihidWZmZXIpLWosDQo+ICsJCQkJCSAgICAgICAiJTA4eCAi
LCBjZmcpOw0KPiArCQkJfQ0KPiArDQo+ICsJCQlpZiAoKGkgJSA0KSA9PSAzIHx8IGkgPj0gOCkN
Cj4gKwkJCQlwcl93YXJuKCIlc1xuIiwgYnVmZmVyKTsNCj4gIAkJfQ0KPiAgCX0NCg0KCURhdmlk
DQoNCg==
