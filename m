Return-Path: <r63061@freescale.com>
Received: from tx2outboundpool.messaging.microsoft.com
 (tx2ehsobe001.messaging.microsoft.com [65.55.88.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 31BF42C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 13:32:02 +1100 (EST)
Received: from mail222-tx2 (localhost [127.0.0.1])	by
 mail222-tx2-R.bigfish.com (Postfix) with ESMTP id 6596F400061	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 02:31:58 +0000 (UTC)
Received: from TX2EHSMHS023.bigfish.com (unknown [10.9.14.244])	by
 mail222-tx2.bigfish.com (Postfix) with ESMTP id 2218220089	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,  6 Nov 2013 02:31:56 +0000 (UTC)
From: Xiaobo Xie <r63061@freescale.com>
To: Scott Wood <B07421@freescale.com>
Subject: RE: [PATCH V4 3/3] powerpc/85xx: Add TWR-P1025 board support
Date: Wed, 6 Nov 2013 02:31:54 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D62F8A5@039-SN1MPN1-004.039d.mgd.msft.net>
References: <1380019739-8196-1-git-send-email-X.Xie@freescale.com>
 <1380019739-8196-3-git-send-email-X.Xie@freescale.com>
 <1380064944.24959.143.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5FF91C@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380150578.24959.213.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D600530@039-SN1MPN1-003.039d.mgd.msft.net>
 <1380230838.24959.322.camel@snotra.buserror.net>
In-Reply-To: <1380230838.24959.322.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Michael Johnston <r49610@freescale.com>,
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
Y290dC1CMDc0MjENCj4gU2VudDogRnJpZGF5LCBTZXB0ZW1iZXIgMjcsIDIwMTMgNToyNyBBTQ0K
PiBUbzogWGllIFhpYW9iby1SNjMwNjENCj4gQ2M6IFdvb2QgU2NvdHQtQjA3NDIxOyBsaW51eHBw
Yy1kZXZAbGlzdHMub3psYWJzLm9yZzsgSm9obnN0b24gTWljaGFlbC0NCj4gUjQ5NjEwDQo+IFN1
YmplY3Q6IFJlOiBbUEFUQ0ggVjQgMy8zXSBwb3dlcnBjLzg1eHg6IEFkZCBUV1ItUDEwMjUgYm9h
cmQgc3VwcG9ydA0KPiANCj4gPiA+ID4gPiA+ICsJLyogQ1MyIGZvciBEaXNwbGF5ICovDQo+ID4g
PiA+ID4gPiArCXNzZDEyODlAMiwwIHsNCj4gPiA+ID4gPiA+ICsJCSNhZGRyZXNzLWNlbGxzID0g
PDE+Ow0KPiA+ID4gPiA+ID4gKwkJI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gPiA+ID4gPiArCQlj
b21wYXRpYmxlID0gInNzZDEyODkiOw0KPiA+ID4gPiA+ID4gKwkJcmVnID0gPDB4MiAweDAwMDAg
MHgwMDAyDQo+ID4gPiA+ID4gPiArCQkgICAgICAgMHgyIDB4MDAwMiAweDAwMDI+Ow0KPiA+ID4g
PiA+ID4gKwl9Ow0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gTm9kZSBuYW1lcyBzaG91bGQgYmUgZ2Vu
ZXJpYy4gIFdoYXQgZG9lcyBzc2QxMjg5IGRvPyAgSWYgdGhpcyBpcw0KPiA+ID4gPiA+IGFjdHVh
bGx5IHRoZSBkaXNwbGF5IGRldmljZSwgdGhlbiBpdCBzaG91bGQgYmUgY2FsbGVkDQo+ICJkaXNw
bGF5QDIsMCIuDQo+ID4gPiA+DQo+ID4gPiA+IE9LLiBUaGUgc3NkMTI4OSBpcyBhIExDRCBjb250
cm9sbGVyLg0KPiA+ID4gPg0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gSG93IGFib3V0IGEgdmVuZG9y
IHByZWZpeCBvbiB0aGF0IGNvbXBhdGlibGU/ICBXaHkNCj4gPiA+ID4gPiAjYWRkcmVzcy1jZWxs
cy8jc2l6ZS0gY2VsbHMgZGVzcGl0ZSBubyBjaGlsZCBub2Rlcz8gIFdoZXJlIGlzIGENCj4gPiA+
ID4gPiBiaW5kaW5nIHRoYXQgc2F5cyB3aGF0IGVhY2ggb2YgdGhvc2UgdHdvIHJlZyByZXNvdXJj
ZXMgbWVhbj8NCj4gPiA+ID4NCj4gPiA+ID4gSSB3aWxsIGFkZCB0aGUgdmVuZG9yIHByZWZpeC4g
SSByZXZpZXcgdGhlIHNzZDEyODkgZHJpdmVyLCBhbmQgdGhlDQo+ID4gPiAjYWRkcmVzcy1jZWxs
cy8jc2l6ZS1jZWxscyB3ZXJlIHVuLXVzZWQuIEkgd2lsbCByZW1vdmUgdGhlbS4NCj4gPiA+DQo+
ID4gPiBBbmQgYSBiaW5kaW5nPw0KPiA+ID4NCj4gPiA+IFdoeSBkbyB5b3UgbmVlZCB0d28gc2Vw
YXJhdGUgcmVnIHJlc291cmNlcyByYXRoZXIgdGhhbiBqdXN0IDwyIDAgND4/DQo+ID4gPiBXaWxs
IHRoZXkgZXZlciBiZSBkaXNjb250aWd1b3VzPw0KPiA+DQo+ID4gW1hpZV0gSSByZXZpZXcgdGhl
IHNzZDEyODkgZHJpdmVyIGNvZGUsIGFuZCBmb3VuZCB0aGUgZHJpdmVyIG5lZWQgdHdvDQo+ID4g
cmVnIHJlc291cmNlcywNCj4gDQo+IFRoZSBkZXZpY2UgdHJlZSBkZXNjcmliZXMgdGhlIGhhcmR3
YXJlLCBub3QgdGhlIGN1cnJlbnQgc3RhdGUgb2YgTGludXgNCj4gZHJpdmVycy4gIEVzcGVjaWFs
bHkgZHJpdmVycyB0aGF0IGFyZW4ndCB5ZXQgaW4gTGludXguIDotKQ0KPiANCg0KT0ssIEkgd2ls
bCByZW1haW4gdGhlIGRpc3BsYXkgbm9kZS4NCg0KPiA+IGlmIGNoYW5nZSB0aGUgZHRzLCB0aGUg
ZHJpdmVyIGFsc28gc2hvdWxkIGJlIG1vZGlmaWVkIGFjY29yZGluZ2x5LiBTbw0KPiA+IEkgcmVt
b3ZlIHRoZSBzc2QxMjg5IG5vZGUgZnJvbSB0aGlzIHBhdGNoLiBJIHdpbGwgc3VibWl0IG5ldyBw
YXRjaA0KPiA+IGluY2x1ZGUgdGhlIGR0cyBtb2RpZmljYXRpb24sIHNzZDEyODkgZHJpdmVyIGFu
ZCB0aGUgYmluZGluZy4NCj4gDQo+IElkZWFsbHkgYWxsIGRldmljZXMgKGFuZCBiaW5kaW5ncykg
c2hvdWxkIGJlIGRlc2NyaWJlZCB3aGVuIHRoZSBkZXZpY2UNCj4gdHJlZSBpcyBpbml0YWxseSBh
ZGRlZCwgcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHlvdSBoYXZlIGEgZHJpdmVyIHlldC4NCj4gDQog
DQpJIHdpbGwgYWRkIGEgYmluZGluZyBkb2N1bWVudCBmb3IgdGhlIHNzZDEyODkgZGV2aWNlLg0K
DQo+IC1TY290dA0KPiANCi0gWGlhb2JvDQo=
