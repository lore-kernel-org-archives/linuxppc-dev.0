Return-Path: <Dongsheng.Wang@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0238.outbound.protection.outlook.com [207.46.163.238])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 65B3D2C00BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 21:01:44 +1100 (EST)
From: "Dongsheng.Wang@freescale.com" <Dongsheng.Wang@freescale.com>
To: Scott Wood <scottwood@freescale.com>
Subject: RE: [PATCH 2/2] powerpc/85xx: handle the eLBC error interrupt if it
 exist in dts
Date: Tue, 7 Jan 2014 10:01:33 +0000
Message-ID: <1acd410af7444ba89e81dc004f2d6e89@BN1PR03MB188.namprd03.prod.outlook.com>
References: <1389076061-20159-1-git-send-email-dongsheng.wang@freescale.com>
 <1389077881.11795.137.camel@snotra.buserror.net>
In-Reply-To: <1389077881.11795.137.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, Shaohui
 Xie <Shaohui.Xie@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBTY290dC1CMDc0
MjENCj4gU2VudDogVHVlc2RheSwgSmFudWFyeSAwNywgMjAxNCAyOjU4IFBNDQo+IFRvOiBXYW5n
IERvbmdzaGVuZy1CNDA1MzQNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBY
aWUgU2hhb2h1aS1CMjE5ODk7IEt1bWFyIEdhbGENCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJd
IHBvd2VycGMvODV4eDogaGFuZGxlIHRoZSBlTEJDIGVycm9yIGludGVycnVwdCBpZiBpdA0KPiBl
eGlzdCBpbiBkdHMNCj4gDQo+IE9uIFR1ZSwgMjAxNC0wMS0wNyBhdCAxNDoyNyArMDgwMCwgRG9u
Z3NoZW5nIFdhbmcgd3JvdGU6DQo+ID4gRnJvbTogV2FuZyBEb25nc2hlbmcgPGRvbmdzaGVuZy53
YW5nQGZyZWVzY2FsZS5jb20+DQo+IA0KPiBBRkFJQ1QgdGhpcyBwYXRjaCB3YXMgb3JpZ2luYWxs
eSB3cml0dGVuIGJ5IFNoYW9odWkgWGllLg0KPiANCj4gPiBPbiBQMzA0MSwgUDEwMjAsIFAxMDIx
LCBQMTAyMiwgUDEwMjMgZUxCQyBldmVudCBpbnRlcnJ1cHRzIGFyZSByb3V0ZWQNCj4gPiB0byBJ
bnQ5KFAzMDQxKSAmIEludDMoUDEwMngpIHdoaWxlIEVMQkMgZXJyb3IgaW50ZXJydXB0cyBhcmUg
cm91dGVkIHRvDQo+ID4gSW50MCwgd2UgbmVlZCB0byBjYWxsIHJlcXVlc3RfaXJxIGZvciBlYWNo
Lg0KPiANCj4gRm9yIHAzMDQxIEkgdGhvdWdodCB0aGF0IHdhcyBvbmx5IG9uIGVhcmx5IHNpbGlj
b24gcmV2cyB0aGF0IHdlIGRvbid0DQo+IHN1cHBvcnQgYW55bW9yZS4NCj4gDQo+IEFzIGZvciBw
MTAyeCwgaGF2ZSB5b3UgdGVzdGVkIHRoYXQgdGhpcyBpcyBhY3R1YWxseSB3aGF0IGhhcHBlbnM/
ICBIb3cNCj4gd291bGQgd2UgZGlzdGluZ3Vpc2ggZUxCQyBlcnJvcnMgZnJvbSBvdGhlciBlcnJv
ciBzb3VyY2VzLCBnaXZlbiB0aGF0DQo+IHRoZXJlJ3Mgbm8gRUlTUjA/ICBEbyB3ZSBqdXN0IGhv
cGUgdGhhdCBubyBvdGhlciBlcnJvciBpbnRlcnJ1cHRzDQo+IGhhcHBlbj8NClllcywgSSB0ZXN0
ZWQuIFRoZSBpbnRlcnJ1cHQgaXMgc2hhcmQgZUxCQyBpbnRlcnJ1cHQgaGFuZGxlciBjb3VsZCBj
aGVjayB0aGUgZXJyb3IuDQpUaGlzIHBhdGNoIGlzIGZpeCAibm9ib2R5IGNhcmVkIiB0aGUgZXJy
b3IgaW50ZXJydXB0LiBBZnRlciBzbGVlcCByZXN1bWUgdGhlIGxiYw0Kd2lsbCBnZXQgYSBjaGlw
IHNlbGVjdCBlcnJvci4NCg0KLURvbmdzaGVuZw0KDQo+IA0KPiAtU2NvdHQNCj4gDQoNCg==
