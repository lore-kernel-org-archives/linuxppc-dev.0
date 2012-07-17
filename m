Return-Path: <B38951@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8BDA82C0177
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jul 2012 16:18:31 +1000 (EST)
From: Jia Hongtao-B38951 <B38951@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH] powerpc/85xx: workaround for chips with MSI hareware
 errata to support MSI-X
Date: Tue, 17 Jul 2012 06:18:20 +0000
Message-ID: <412C8208B4A0464FA894C5F0C278CD5D01A242E6@039-SN1MPN1-002.039d.mgd.msft.net>
References: <1342409730-28340-1-git-send-email-B38951@freescale.com>
 <5004A1B0.6070004@freescale.com>
In-Reply-To: <5004A1B0.6070004@freescale.com>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "soniccat.liu@gmail.com" <soniccat.liu@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFR1ZXNkYXksIEp1bHkgMTcsIDIwMTIgNzoyMCBBTQ0KPiBUbzogSmlhIEhvbmd0
YW8tQjM4OTUxDQo+IENjOiBsaW51eHBwYy1kZXZAbGlzdHMub3psYWJzLm9yZzsgZ2FsYWtAa2Vy
bmVsLmNyYXNoaW5nLm9yZzsNCj4gc29uaWNjYXQubGl1QGdtYWlsLmNvbQ0KPiBTdWJqZWN0OiBS
ZTogW1BBVENIXSBwb3dlcnBjLzg1eHg6IHdvcmthcm91bmQgZm9yIGNoaXBzIHdpdGggTVNJIGhh
cmV3YXJlDQo+IGVycmF0YSB0byBzdXBwb3J0IE1TSS1YDQo+ID4gZGlmZiAtLWdpdCBhL2FyY2gv
cG93ZXJwYy9zeXNkZXYvZnNsX21zaS5oDQo+IGIvYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xfbXNp
LmgNCj4gPiBpbmRleCA4MjI1Zjg2Li4zNTRkNTQ2IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvcG93
ZXJwYy9zeXNkZXYvZnNsX21zaS5oDQo+ID4gKysrIGIvYXJjaC9wb3dlcnBjL3N5c2Rldi9mc2xf
bXNpLmgNCj4gPiBAQCAtMjUsNiArMjUsOSBAQA0KPiA+ICAjZGVmaW5lIEZTTF9QSUNfSVBfSVBJ
QyAgIDB4MDAwMDAwMDINCj4gPiAgI2RlZmluZSBGU0xfUElDX0lQX1ZNUElDICAweDAwMDAwMDAz
DQo+ID4NCj4gPiArI2RlZmluZSBNU0lfSFdfRVJSQVRBX01BU0sgICAweDAwMDAwMEYwDQo+ID4g
KyNkZWZpbmUgTVNJX0hXX0VSUkFUQV9FTkRJQU4gMHgwMDAwMDAxMA0KPiANCj4gV2h5IGRvIHdl
IG5lZWQgYSBtYXNrIGZvciB0aGlzPw0KPiANCg0KSXQgc2VlbXMgdGhpcyBtYXNrIGlzIG5vdCBu
ZWVkZWQuDQpJIHdpbGwgZml4IHRoaXMgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLg0K
LUhvbmd0YW8uDQo=
