Return-Path: <B40534@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe004.messaging.microsoft.com [207.46.163.27])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8FC592C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Aug 2013 19:55:48 +1000 (EST)
From: Wang Dongsheng-B40534 <B40534@freescale.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>, Wood Scott-B07421
 <B07421@freescale.com>
Subject: RE: [PATCH 2/2] powerpc/hibernate: add restore mmu context after
 resume
Date: Wed, 7 Aug 2013 09:55:40 +0000
Message-ID: <ABB05CD9C9F68C46A5CEDC7F15439259010008E6@039-SN2MPN1-022.039d.mgd.msft.net>
References: <1373666090.8183.290@snotra> <1373670396.19894.215.camel@pasglop>
In-Reply-To: <1373670396.19894.215.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Wood Scott-B07421 <B07421@freescale.com>,
 "johannes@sipsolutions.net" <johannes@sipsolutions.net>,
 "anton@enomsg.org" <anton@enomsg.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQmVuamFtaW4gSGVycmVu
c2NobWlkdCBbbWFpbHRvOmJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZ10NCj4gU2VudDogU2F0dXJk
YXksIEp1bHkgMTMsIDIwMTMgNzowNyBBTQ0KPiBUbzogV29vZCBTY290dC1CMDc0MjENCj4gQ2M6
IFdhbmcgRG9uZ3NoZW5nLUI0MDUzNDsgV29vZCBTY290dC1CMDc0MjE7IGpvaGFubmVzQHNpcHNv
bHV0aW9ucy5uZXQ7DQo+IGFudG9uQGVub21zZy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGluZy5v
cmc7IGxpbnV4cHBjLQ0KPiBkZXZAbGlzdHMub3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BB
VENIIDIvMl0gcG93ZXJwYy9oaWJlcm5hdGU6IGFkZCByZXN0b3JlIG1tdSBjb250ZXh0IGFmdGVy
DQo+IHJlc3VtZQ0KPiANCj4gT24gRnJpLCAyMDEzLTA3LTEyIGF0IDE2OjU0IC0wNTAwLCBTY290
dCBXb29kIHdyb3RlOg0KPiA+IHNldF9jb250ZXh0KCkgZG9lc24ndCBleGlzdCBmb3IgaGFzaCBN
TVVzLg0KPiA+DQo+ID4gV2hhdGV2ZXIgeW91IGRvLCBwbGVhc2UgdHJ5IGFjdHVhbGx5IGJ1aWxk
aW5nIGl0IG9uIHZhcmlvdXMgdGFyZ2V0cywNCj4gPiBpbmNsdWRpbmcgYm90aCAzMiBhbmQgNjQg
Yml0cywgYW5kIGJvdGggaGFzaCBhbmQgbm9uLWhhc2guICBBbmQgbWFrZQ0KPiA+IHN1cmUgdGhh
dCB3aGF0ZXZlciBlZmZlY3QgUFBDMzIgd2FzIGRlcGVuZGluZyBvbiBzd2l0Y2hfbW11X2NvbnRl
eHQNCj4gPiBmb3INCj4gPiBpcyBwcmVzZXJ2ZWQsIGluY2x1ZGluZyBvbiBub24tYm9va2UuDQo+
IA0KPiBUaGUgcmlnaHQgdGhpbmcgdG8gZG8gaXMgcHJvYmFibHkgdG8gaGF2ZSB0aGUgdmFyaW91
cyB0bGJfKiBmaWxlcw0KSG93IGFib3V0IG1tdV9jb250ZXh0XyogZmlsZXMgdG8gcHJvdmlkZSBh
IHBhaXIgb2Ygc2F2ZS9yZXN0b3JlIGNvbnRleHQgZnVuY3Rpb25zPw0KDQo+IHByb3ZpZGUgYSBw
YWlyIG9mIHNhdmUvcmVzdG9yZSBmdW5jdGlvbnMgdGhhdCBkbyB0aGUgcmlnaHQgdGhpbmcNCj4g
Zm9yIHRoYXQgc3BlY2lmaWMgTU1VIHR5cGUuDQo+IA0KPiBCZW4uDQo+IA0KPiANCg0K
