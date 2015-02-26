Return-Path: <hongtao.jia@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0128.outbound.protection.outlook.com [65.55.169.128])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5CF5C1A0023
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Feb 2015 13:55:44 +1100 (AEDT)
From: Hongtao Jia <hongtao.jia@freescale.com>
To: Scott Wood <scottwood@freescale.com>, Arseny Solokha <asolokha@kb.kras.ru>
Subject: RE: [PATCH 4/4] powerpc/mpic: remove unused functions
Date: Thu, 26 Feb 2015 02:39:46 +0000
Message-ID: <BLUPR03MB1490887B3ADF3E598BFE276E1140@BLUPR03MB149.namprd03.prod.outlook.com>
References: <1424084188-17097-1-git-send-email-asolokha@kb.kras.ru>
 <1424084188-17097-5-git-send-email-asolokha@kb.kras.ru>
 <1424307520.22020.5.camel@ellerman.id.au>
 <87d256kry8.fsf@KB00016249.iskra.kb> <1424727116.4698.2.camel@freescale.com>
In-Reply-To: <1424727116.4698.2.camel@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Paul Mackerras <paulus@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNCkknbSByZWFsbHkgc29ycnkgZm9yIGxlYXZlIHRoaXMgcGF0Y2ggbGlrZSBh
IHpvbWJpZS4NCk5vdyBJIGhhdmUgcGxhbiB0byByZXZpc2l0IHRoaXMgcGF0Y2guDQoNCkZyb20g
dGhlIHByZXZpb3VzIGNvbW1lbnRzIHRoZSBjb21waWxlIGVycm9yIHdhcyBmaXhlZC4NCkJ1dCBi
ZXlvbmQgdGhhdCBJIGhhdmUgaGFkIG5vIHBsYW4gdG8gdXBkYXRlIGl0Lg0KDQpDb3VsZCB5b3Ug
cGxlYXNlIGNvbW1lbnQgb24gd2h5IGl0J3Mgc3RpbGwgb24gaG9sZD8NCg0KVGhhbmtzLg0KDQoN
Cj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0MjEN
Cj4gU2VudDogVHVlc2RheSwgRmVicnVhcnkgMjQsIDIwMTUgNTozMiBBTQ0KPiBUbzogQXJzZW55
IFNvbG9raGENCj4gQ2M6IE1pY2hhZWwgRWxsZXJtYW47IEJlbmphbWluIEhlcnJlbnNjaG1pZHQ7
IFBhdWwgTWFja2VycmFzOyBsaW51eHBwYy0NCj4gZGV2QGxpc3RzLm96bGFicy5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7IEppYSBIb25ndGFvLUIzODk1MQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIIDQvNF0gcG93ZXJwYy9tcGljOiByZW1vdmUgdW51c2VkIGZ1bmN0aW9ucw0KPiAN
Cj4gT24gVGh1LCAyMDE1LTAyLTE5IGF0IDE5OjI2ICswNzAwLCBBcnNlbnkgU29sb2toYSB3cm90
ZToNCj4gPiAgICsgZnNsX21waWNfcHJpbWFyeV9nZXRfdmVyc2lvbigpIGlzIGp1c3QgYSBzYWZl
IHdyYXBwZXIgYXJvdW5kDQo+ID4gZnNsX21waWNfZ2V0X3ZlcnNpb24oKSBmb3IgU01QIGNvbmZp
Z3VyYXRpb25zLiBXaGlsZSB0aGUgbGF0dGVyIGlzDQo+ID4gY2FsbGVkIGV4cGxpY2l0bHkgZm9y
IGhhbmRsaW5nIFBJQyBpbml0aWFsaXphdGlvbiBhbmQgc2V0dGluZyB1cCBlcnJvcg0KPiA+IGlu
dGVycnVwdCB2ZWN0b3IgZGVwZW5kaW5nIG9uIFBJQyBoYXJkd2FyZSB2ZXJzaW9uLCB0aGUgZm9y
bWVyIGlzbid0DQo+ID4gdXNlZCBmb3IgYW55dGhpbmcuDQo+IA0KPiBJdCB3YXMgbWVhbnQgdG8g
YmUgdXNlZCBieSBodHRwOi8vcGF0Y2h3b3JrLm96bGFicy5vcmcvcGF0Y2gvMjMzMjExLw0KPiB3
aGljaCBuZXZlciBnb3QgcmVzcHVuLiAgSG9uZ3RhbywgZG8geW91IHBsYW4gdG8gcmV2aXNpdCB0
aGF0IHBhdGNoPw0KPiANCj4gLVNjb3R0DQo+IA0KDQo=
