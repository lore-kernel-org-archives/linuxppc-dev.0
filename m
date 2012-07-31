Return-Path: <B16395@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe002.messaging.microsoft.com [216.32.180.185])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A01A92C0083
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Aug 2012 00:10:11 +1000 (EST)
From: Sethi Varun-B16395 <B16395@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>, Kumar Gala
 <galak@kernel.crashing.org>
Subject: RE: [PATCH 1/3] powerpc/mpic: finish supporting timer group B on
 Freescale chips
Date: Tue, 31 Jul 2012 14:09:59 +0000
Message-ID: <C5ECD7A89D1DC44195F34B25E172658D14C35D@039-SN2MPN1-013.039d.mgd.msft.net>
References: <1341823542-15654-1-git-send-email-Varun.Sethi@freescale.com>
 <58A5C37E-E2AA-4135-8419-9070FAFE84A2@kernel.crashing.org>
 <4FFB0A17.2030501@freescale.com>
 <66B03D29-D273-4E1A-8CAB-F7A9367587A5@kernel.crashing.org>
 <4FFB17F8.3060507@freescale.com>
In-Reply-To: <4FFB17F8.3060507@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogTW9uZGF5LCBKdWx5IDA5LCAyMDEyIDExOjEyIFBNDQo+IFRvOiBLdW1hciBH
YWxhDQo+IENjOiBTZXRoaSBWYXJ1bi1CMTYzOTU7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggMS8zXSBwb3dlcnBjL21waWM6IGZpbmlzaCBzdXBw
b3J0aW5nIHRpbWVyIGdyb3VwIEIgb24NCj4gRnJlZXNjYWxlIGNoaXBzDQo+IA0KPiBPbiAwNy8w
OS8yMDEyIDEyOjM2IFBNLCBLdW1hciBHYWxhIHdyb3RlOg0KPiA+DQo+ID4gT24gSnVsIDksIDIw
MTIsIGF0IDExOjQzIEFNLCBTY290dCBXb29kIHdyb3RlOg0KPiA+DQo+ID4+IE9uIDA3LzA5LzIw
MTIgMDk6MTIgQU0sIEt1bWFyIEdhbGEgd3JvdGU6DQo+ID4+Pg0KPiA+Pj4gT24gSnVsIDksIDIw
MTIsIGF0IDM6NDUgQU0sIFZhcnVuIFNldGhpIHdyb3RlOg0KPiA+Pj4NCj4gPj4+PiBQcmV2aW91
c2x5LCB0aGVzZSBpbnRlcnJ1cHRzIHdvdWxkIGJlIG1hcHBlZCwgYnV0IHRoZSBvZmZzZXQNCj4g
Pj4+PiBjYWxjdWxhdGlvbiB3YXMgYnJva2VuLCBhbmQgb25seSB0aGUgZmlyc3QgZ3JvdXAgd2Fz
IGluaXRpYWxpemVkLg0KPiA+Pj4+DQo+ID4+Pj4gU2lnbmVkLW9mZi1ieTogU2NvdHQgV29vZCA8
c2NvdHR3b29kQGZyZWVzY2FsZS5jb20+DQo+ID4+Pj4gLS0tDQo+ID4+Pj4gYXJjaC9wb3dlcnBj
L2luY2x1ZGUvYXNtL21waWMuaCB8ICAgIDUgKysrDQo+ID4+Pj4gYXJjaC9wb3dlcnBjL3N5c2Rl
di9tcGljLmMgICAgICB8ICAgNTggKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0NCj4gLS0t
LS0tLS0tLQ0KPiA+Pj4+IDIgZmlsZXMgY2hhbmdlZCwgNDcgaW5zZXJ0aW9ucygrKSwgMTYgZGVs
ZXRpb25zKC0pDQo+ID4+DQpTaWduZWQtb2ZmLWJ5OiBWYXJ1biBTZXRoaSA8dmFydW4uc2V0aGlA
ZnJlZXNjYWxlLmNvbT4NCg==
