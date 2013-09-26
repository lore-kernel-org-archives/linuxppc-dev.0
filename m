Return-Path: <r63061@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E69482C00D1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 19:28:03 +1000 (EST)
Received: from mail54-va3 (localhost [127.0.0.1])	by mail54-va3-R.bigfish.com
 (Postfix) with ESMTP id 5D17148009F	for
 <linuxppc-dev@lists.ozlabs.org>; Thu,
 26 Sep 2013 09:27:59 +0000 (UTC)
Received: from VA3EHSMHS001.bigfish.com (unknown [10.7.14.231])	by
 mail54-va3.bigfish.com (Postfix) with ESMTP id B51F5440041	for
 <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Sep 2013 09:27:56 +0000 (UTC)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
Date: Thu, 26 Sep 2013 09:27:54 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D600530@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380150578.24959.213.camel@snotra.buserror.net>
In-Reply-To: <1380150578.24959.213.camel@snotra.buserror.net>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBXb29kIFNjb3R0LUIwNzQyMQ0K
PiBTZW50OiBUaHVyc2RheSwgU2VwdGVtYmVyIDI2LCAyMDEzIDc6MTAgQU0NCj4gVG86IFhpZSBY
aWFvYm8tUjYzMDYxDQo+IENjOiBXb29kIFNjb3R0LUIwNzQyMTsgbGludXhwcGMtZGV2QGxpc3Rz
Lm96bGFicy5vcmc7IEpvaG5zdG9uIE1pY2hhZWwtDQo+IFI0OTYxMA0KPiBTdWJqZWN0OiBSZTog
W1BBVENIIFY0IDMvM10gcG93ZXJwYy84NXh4OiBBZGQgVFdSLVAxMDI1IGJvYXJkIHN1cHBvcnQN
Cj4gDQo+IE9uIFdlZCwgMjAxMy0wOS0yNSBhdCAwNDo1MCAtMDUwMCwgWGllIFhpYW9iby1SNjMw
NjEgd3JvdGU6DQo+ID4gSGkgU2NvdHQsDQo+ID4NCj4gPiBTZWUgdGhlIHJlcGx5IGlubGluZS4N
Cj4gPg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IFdvb2Qg
U2NvdHQtQjA3NDIxDQo+ID4gPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAyNSwgMjAxMyA3
OjIyIEFNDQo+ID4gPiBUbzogWGllIFhpYW9iby1SNjMwNjENCj4gPiA+IENjOiBsaW51eHBwYy1k
ZXZAbGlzdHMub3psYWJzLm9yZzsgSm9obnN0b24gTWljaGFlbC1SNDk2MTANCj4gPiA+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggVjQgMy8zXSBwb3dlcnBjLzg1eHg6IEFkZCBUV1ItUDEwMjUgYm9hcmQN
Cj4gPiA+IHN1cHBvcnQNCj4gPiA+DQo+ID4gPiBPbiBUdWUsIDIwMTMtMDktMjQgYXQgMTg6NDgg
KzA4MDAsIFhpZSBYaWFvYm8gd3JvdGU6DQo+ID4gPiA+ICsJCXBhcnRpdGlvbkA4MDAwMCB7DQo+
ID4gPiA+ICsJCQkvKiAzLjUgTUIgZm9yIExpbnV4IEtlcm5lbCBJbWFnZSAqLw0KPiA+ID4gPiAr
CQkJcmVnID0gPDB4MDAwODAwMDAgMHgwMDM4MDAwMD47DQo+ID4gPiA+ICsJCQlsYWJlbCA9ICJO
T1IgTGludXggS2VybmVsIEltYWdlIjsNCj4gPiA+ID4gKwkJfTsNCj4gPiA+DQo+ID4gPiBJcyB0
aGlzIGVub3VnaD8NCj4gPg0KPiA+IEkgd2lsbCBlbmxhcmdlIGl0IHRvIDZNQi4NCj4gPg0KPiA+
ID4NCj4gPiA+ID4gKwkJcGFydGl0aW9uQDQwMDAwMCB7DQo+ID4gPiA+ICsJCQkvKiA1OC43NU1C
IGZvciBKRkZTMiBiYXNlZCBSb290IGZpbGUgU3lzdGVtICovDQo+ID4gPiA+ICsJCQlyZWcgPSA8
MHgwMDQwMDAwMCAweDAzYWMwMDAwPjsNCj4gPiA+ID4gKwkJCWxhYmVsID0gIk5PUiBSb290IEZp
bGUgU3lzdGVtIjsNCj4gPiA+ID4gKwkJfTsNCj4gPiA+DQo+ID4gPiBEb24ndCBzcGVjaWZ5IGpm
ZnMyLg0KPiA+DQo+ID4gT0ssIEkgd2lsbCByZW1vdmUgImpmZnMyIg0KPiA+DQo+ID4gPg0KPiA+
ID4gPiArCS8qIENTMiBmb3IgRGlzcGxheSAqLw0KPiA+ID4gPiArCXNzZDEyODlAMiwwIHsNCj4g
PiA+ID4gKwkJI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+ID4gPiA+ICsJCSNzaXplLWNlbGxzID0g
PDE+Ow0KPiA+ID4gPiArCQljb21wYXRpYmxlID0gInNzZDEyODkiOw0KPiA+ID4gPiArCQlyZWcg
PSA8MHgyIDB4MDAwMCAweDAwMDINCj4gPiA+ID4gKwkJICAgICAgIDB4MiAweDAwMDIgMHgwMDAy
PjsNCj4gPiA+ID4gKwl9Ow0KPiA+ID4NCj4gPiA+IE5vZGUgbmFtZXMgc2hvdWxkIGJlIGdlbmVy
aWMuICBXaGF0IGRvZXMgc3NkMTI4OSBkbz8gIElmIHRoaXMgaXMNCj4gPiA+IGFjdHVhbGx5IHRo
ZSBkaXNwbGF5IGRldmljZSwgdGhlbiBpdCBzaG91bGQgYmUgY2FsbGVkICJkaXNwbGF5QDIsMCIu
DQo+ID4NCj4gPiBPSy4gVGhlIHNzZDEyODkgaXMgYSBMQ0QgY29udHJvbGxlci4NCj4gPg0KPiA+
ID4NCj4gPiA+IEhvdyBhYm91dCBhIHZlbmRvciBwcmVmaXggb24gdGhhdCBjb21wYXRpYmxlPyAg
V2h5DQo+ID4gPiAjYWRkcmVzcy1jZWxscy8jc2l6ZS0gY2VsbHMgZGVzcGl0ZSBubyBjaGlsZCBu
b2Rlcz8gIFdoZXJlIGlzIGENCj4gPiA+IGJpbmRpbmcgdGhhdCBzYXlzIHdoYXQgZWFjaCBvZiB0
aG9zZSB0d28gcmVnIHJlc291cmNlcyBtZWFuPw0KPiA+DQo+ID4gSSB3aWxsIGFkZCB0aGUgdmVu
ZG9yIHByZWZpeC4gSSByZXZpZXcgdGhlIHNzZDEyODkgZHJpdmVyLCBhbmQgdGhlDQo+ICNhZGRy
ZXNzLWNlbGxzLyNzaXplLWNlbGxzIHdlcmUgdW4tdXNlZC4gSSB3aWxsIHJlbW92ZSB0aGVtLg0K
PiANCj4gQW5kIGEgYmluZGluZz8NCj4gDQo+IFdoeSBkbyB5b3UgbmVlZCB0d28gc2VwYXJhdGUg
cmVnIHJlc291cmNlcyByYXRoZXIgdGhhbiBqdXN0IDwyIDAgND4/DQo+IFdpbGwgdGhleSBldmVy
IGJlIGRpc2NvbnRpZ3VvdXM/DQoNCltYaWVdIEkgcmV2aWV3IHRoZSBzc2QxMjg5IGRyaXZlciBj
b2RlLCBhbmQgZm91bmQgdGhlIGRyaXZlciBuZWVkIHR3byByZWcgcmVzb3VyY2VzLCBpZiBjaGFu
Z2UgdGhlIGR0cywgdGhlIGRyaXZlciBhbHNvIHNob3VsZCBiZSBtb2RpZmllZCBhY2NvcmRpbmds
eS4gU28gSSByZW1vdmUgdGhlIHNzZDEyODkgbm9kZSBmcm9tIHRoaXMgcGF0Y2guIEkgd2lsbCBz
dWJtaXQgbmV3IHBhdGNoIGluY2x1ZGUgdGhlIGR0cyBtb2RpZmljYXRpb24sIHNzZDEyODkgZHJp
dmVyIGFuZCB0aGUgYmluZGluZy4gICANCg0KPiANCj4gLVNjb3R0DQo+IA0KDQo=
