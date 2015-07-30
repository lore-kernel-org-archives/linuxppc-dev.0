Return-Path: <B48286@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0132.outbound.protection.outlook.com [65.55.169.132])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05A191A117E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jul 2015 20:03:02 +1000 (AEST)
From: Hou Zhiqiang <B48286@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>, Hu Vincent
 <Mingkai.Hu@freescale.com>
Subject: RE: [PATCH] powerpc/fsl-pci: fix pcie range issue for some P1/P2
 boards
Date: Thu, 30 Jul 2015 10:02:54 +0000
Message-ID: <CY1PR0301MB07804B475D69492556138A2A8B8B0@CY1PR0301MB0780.namprd03.prod.outlook.com>
References: <1437559704-13332-1-git-send-email-B48286@freescale.com>
 <1437792504.2993.280.camel@freescale.com>
 <CY1PR0301MB0780D3C72FF1F86DE25345CE8B8C0@CY1PR0301MB0780.namprd03.prod.outlook.com>
 <1438137329.2993.328.camel@freescale.com>
In-Reply-To: <1438137329.2993.328.camel@freescale.com>
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

SGkgU2NvdHQsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogV29vZCBT
Y290dC1CMDc0MjENCj4gU2VudDogMjAxNeW5tDfmnIgyOeaXpSAxMDozNQ0KPiBUbzogSG91IFpo
aXFpYW5nLUI0ODI4Ng0KPiBDYzogbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGJlbmhA
a2VybmVsLmNyYXNoaW5nLm9yZzsNCj4gcGF1bHVzQHNhbWJhLm9yZzsgbXBlQGVsbGVybWFuLmlk
LmF1OyBIdSBNaW5na2FpLUIyMTI4NA0KPiBTdWJqZWN0OiBSZTogW1BBVENIXSBwb3dlcnBjL2Zz
bC1wY2k6IGZpeCBwY2llIHJhbmdlIGlzc3VlIGZvciBzb21lIFAxL1AyDQo+IGJvYXJkcw0KPiAN
Cj4gT24gVHVlLCAyMDE1LTA3LTI4IGF0IDIxOjM0IC0wNTAwLCBIb3UgWmhpcWlhbmctQjQ4Mjg2
IHdyb3RlOg0KPiA+IEhpIFNjb3R0IGFuZCBhbGwsDQo+ID4NCj4gPiBQbGVhc2UgaWdub3JlIHRo
aXMgcGF0Y2ghDQo+IA0KPiBEaWQgeW91IGZpZ3VyZSBvdXQgd2hhdCB3YXMgYWN0dWFsbHkgY2F1
c2luZyB5b3UgdG8gc2VlIENQVSBzdGFsbHM/DQo+DQoNClRoaXMgaXNzdWUgZml4ZWQgYnkgY2Y0
ZDFjZjVhYzVlN2QyYjg4NmFmNmVkOTA2ZWEwZGNkYzViNjg1NSBpbiB1cHN0cmVhbS4NCiANCj4g
LVNjb3R0DQoNClRoYW5rcywNClpoaXFpYW5nDQo=
