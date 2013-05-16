Return-Path: <R65777@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0248.outbound.messaging.microsoft.com [213.199.154.248])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 863652C007E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 May 2013 16:48:11 +1000 (EST)
From: Bhushan Bharat-R65777 <R65777@freescale.com>
To: tiejun.chen <tiejun.chen@windriver.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>
Subject: RE: SATA FSL and upstreaming
Date: Thu, 16 May 2013 06:48:03 +0000
Message-ID: <6A3DF150A5B70D4F9B66A25E3F7C888D0701C498@039-SN2MPN1-012.039d.mgd.msft.net>
References: <1368679657.9603.32.camel@pasglop>
 <1368683156.9603.34.camel@pasglop>
 <6A3DF150A5B70D4F9B66A25E3F7C888D0701C307@039-SN2MPN1-012.039d.mgd.msft.net>
 <3E027F8168735B46AC006B1D0C7BB0020B1E040F@039-SN2MPN1-011.039d.mgd.msft.net>
 <1368684547.9603.38.camel@pasglop> <51947A00.9010504@windriver.com>
 <1368685307.9603.39.camel@pasglop> <51947E35.30808@windriver.com>
 <1368686426.9603.49.camel@pasglop> <5194800D.3010606@windriver.com>
In-Reply-To: <5194800D.3010606@windriver.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Liu Qiang-B32616 <B32616@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Fleming Andy-AFLEMING <afleming@freescale.com>,
 Zang Roy-R61911 <r61911@freescale.com>,
 Xie Shaohui-B21989 <B21989@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogdGllanVuLmNoZW4gW21h
aWx0bzp0aWVqdW4uY2hlbkB3aW5kcml2ZXIuY29tXQ0KPiBTZW50OiBUaHVyc2RheSwgTWF5IDE2
LCAyMDEzIDEyOjEzIFBNDQo+IFRvOiBCZW5qYW1pbiBIZXJyZW5zY2htaWR0DQo+IENjOiBaYW5n
IFJveS1SNjE5MTE7IExpdSBRaWFuZy1CMzI2MTY7IEZsZW1pbmcgQW5keS1BRkxFTUlORzsgbGlu
dXhwcGMtDQo+IGRldkBsaXN0cy5vemxhYnMub3JnOyBYaWUgU2hhb2h1aS1CMjE5ODk7IEJodXNo
YW4gQmhhcmF0LVI2NTc3Nw0KPiBTdWJqZWN0OiBSZTogU0FUQSBGU0wgYW5kIHVwc3RyZWFtaW5n
DQo+IA0KPiBPbiAwNS8xNi8yMDEzIDAyOjQwIFBNLCBCZW5qYW1pbiBIZXJyZW5zY2htaWR0IHdy
b3RlOg0KPiA+IE9uIFRodSwgMjAxMy0wNS0xNiBhdCAxNDozNSArMDgwMCwgdGllanVuLmNoZW4g
d3JvdGU6DQo+ID4+IE9uIDA1LzE2LzIwMTMgMDI6MjEgUE0sIEJlbmphbWluIEhlcnJlbnNjaG1p
ZHQgd3JvdGU6DQo+ID4+PiBPbiBUaHUsIDIwMTMtMDUtMTYgYXQgMTQ6MTcgKzA4MDAsIHRpZWp1
bi5jaGVuIHdyb3RlOg0KPiA+Pj4+IEkgdGhpbmsgeW91IGNhbiB1c2UgQmhhcmF0J3MgUkNXLCB3
aGljaCBzZWVtcyBSUl9IWEFQTlNQXzB4MzYsIHRoZW4NCj4gPj4+PiBwbGVhc2UgdGFrZSBhIGxv
b2sgYXQgdGhpczoNCj4gPj4+DQo+ID4+PiBPaywgaG93IGRvIEkgdXBkYXRlIG15IFJDVyB0byBi
c2UgQmhhcmF0J3MgPw0KPiA+Pg0KPiA+Pg0KPiA+PiBGaXJzdGx5IHBsZWFzZSBjaGVjayB3aGlj
aCBmbGFzaCBiYW5rIGlzIHVzZWQgc2luY2Ugd2UgaGF2ZSB0byBrbm93DQo+ID4+IHdoZXJlIHNo
b3VsZCBiZSB1cGRhdGVkIFJDVy4NCj4gPj4NCj4gPj4gV2hhdCBpcyBTVzdbMTo0XT8NCj4gPj4N
Cj4gPj4gT3Igd2UgaGF2ZSBhbm90aGVyIHNpbXBsZSB3YXkgaW4gdS1ib290IHByb21wdDoNCj4g
Pj4NCj4gPj4gPT4gbWQuYiBmZmRmMDAyYw0KPiA+PiBmZmRmMDAyYzogNGYgMDAgZmUgMDAgMzkg
MDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgMDAgICAgTy4uLjkuLi4uLi4uLi4uLg0KPiA+
PiAuLi4NCj4gPg0KPiA+IGZmZGYwMDJjOiAwZiAwMCBmZSAwMCAwMCAwMCAwMCAwMCAwMCAwMCAw
MCAwMCAwMCAwMCAwMCAwMCAgICAuLi4uLi4uLi4uLi4uLi4uDQo+ID4NCj4gPj4gVGhpcyBtZWFu
cyB3ZSdyZSBvbiBiYW5rNC4NCj4gPg0KPiA+IEkgYXNzdW1lIHRoYXQgbWVhbnMgYmFuazAgPw0K
PiANCj4gWWVzLCBSQ1cgc2hvdWxkIGJlIGJ1cm5lZCB0byAweGVjMDAwMDAwLg0KPiANCj4gSW4g
dS1ib290IHByb21wdDoNCj4gDQo+ID0+IGxvYWR5DQo+ICMjIFJlYWR5IGZvciBiaW5hcnkgKHlt
b2RlbSkgZG93bmxvYWQgdG8gMHgwMTAwMDAwMCBhdCAxMTUyMDAgYnBzLi4uDQo+IEMNCj4gDQo+
IFRoZW4gc2VuZCB0aGF0IFJDVyB3aXRoIHltb2RlbSBpbiB5b3VyIHRlcm1pbmFsIGNsaWVudC4N
Cg0KMSkgTG9hZCBSQ1cgYXMgVGllanVuIG9uIHNvbWUgYWRkcmVzcyBpbiBERFIuDQoNCjIpIEJy
dW4gUkNXIGF0IDB4ZWMwMDAwMDA6DQpwcm90ZWN0IG9mZiAweGVjMDAwMDAwICskZmlsZXNpemU7
IGVyYXNlIDB4ZWMwMDAwMDAgKyRmaWxlc2l6ZTsgY3AuYiAweDEwMDAwMDAgMHhlYzAwMDAwMCAk
ZmlsZXNpemUNCg0KMykgcnVuICIgcGl4IGFsdGJhayIgY29tbWFuZA0KDQo0KSBjaGVjayB5b3Ug
YXJlIG9uIGJhbms0DQoNCjUpIElmIHlvdSBhcmUgbHVja2llciB0aGVuIG5ldHdvcmtpbmcgd2ls
bCB3b3JrIGZvciB5b3UuDQoNClRoYW5rcw0KLUJoYXJhdA0KDQo+IA0KPiBUaWVqdW4NCg0K
