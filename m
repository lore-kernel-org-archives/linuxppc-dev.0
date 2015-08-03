Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2on0106.outbound.protection.outlook.com [65.55.169.106])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 114CA1A0DAB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  3 Aug 2015 17:36:28 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 1/2] powerpc/mpc85xx: Create dts components for the FSL
 QorIQ DPAA FMan
Date: Mon, 3 Aug 2015 07:36:22 +0000
Message-ID: <DM2PR03MB50930473A7D6DD5B7FD7D20E6770@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1438230764-10951-1-git-send-email-igal.liberman@freescale.com>
 <1438286389.2993.365.camel@freescale.com>
In-Reply-To: <1438286389.2993.365.camel@freescale.com>
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

DQoNClJlZ2FyZHMsDQpJZ2FsIExpYmVybWFuLg0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIxDQo+IFNlbnQ6IFRodXJzZGF5LCBKdWx5IDMw
LCAyMDE1IDExOjAwIFBNDQo+IFRvOiBMaWJlcm1hbiBJZ2FsLUIzMTk1MA0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBCdWN1
cg0KPiBNYWRhbGluLUNyaXN0aWFuLUIzMjcxNjsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9y
Zw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIHYyIDEvMl0gcG93ZXJwYy9tcGM4NXh4OiBDcmVhdGUg
ZHRzIGNvbXBvbmVudHMgZm9yDQo+IHRoZSBGU0wgUW9ySVEgRFBBQSBGTWFuDQo+IA0KPiBPbiBU
aHUsIDIwMTUtMDctMzAgYXQgMDc6MzIgKzAzMDAsIElnYWwuTGliZXJtYW4gd3JvdGU6DQo+ID4g
K2ZtYW4wOiAgZm1hbkA0MDAwMDB7DQo+ID4gKyAgICAgI2FkZHJlc3MtY2VsbHMgPSA8MT47DQo+
ID4gKyAgICAgI3NpemUtY2VsbHMgPSA8MT47DQo+ID4gKyAgICAgY2VsbC1pbmRleCA9IDwwPjsN
Cj4gPiArICAgICBjb21wYXRpYmxlID0gImZzbCxmbWFuIjsNCj4gPiArICAgICByYW5nZXMgPSA8
MCAweDQwMDAwMCAweDEwMDAwMD47DQo+ID4gKyAgICAgcmVnID0gPDB4NDAwMDAwIDB4MTAwMDAw
PjsNCj4gPiArICAgICBpbnRlcnJ1cHRzID0gPDk2IDIgMCAwPiwgPDE2IDIgMSAxPjsNCj4gPiAr
ICAgICBjbG9ja3MgPSA8JmNsb2NrZ2VuIDMgMD47DQo+ID4gKyAgICAgY2xvY2stbmFtZXMgPSAi
Zm0wY2xrIjsNCj4gDQo+IGNsb2NrLW5hbWVzIHNob3VsZCBiZSAiZm1hbmNsayIgYXMgcGVyIHRo
ZSBiaW5kaW5nLiAgQW5kIHdoeSB3b3VsZCB5b3UNCj4gd2FudCB0aGUgZHJpdmVyIHRvIGhhdmUg
dG8gZW5jb2RlIHRoZSBmbWFuIGluZGV4IGludG8gdGhlIG5hbWUgaW4gb3JkZXIgdG8NCj4gbG9v
ayB0aGUgY2xvY2sgdXAgYnkgbmFtZT8NCj4gDQoNCldlbGwsIHllcywgdGhpcyBzaG91bGQgYmUg
ImZtYW5jbGsiLiBUaGUgZHJpdmVyIGRvZXNuJ3QgbmVlZCB0byBrbm93IHRoZSBpbmRleC4NCkkn
bGwgZml4IHRoYXQgYW5kIHJlLXN1Ym1pdC4NCg0KSWdhbC4NCg0KPiAtU2NvdHQNCg0K
