Return-Path: <Igal.Liberman@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0137.outbound.protection.outlook.com [207.46.100.137])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14D791A0D2F
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  2 Aug 2015 21:42:32 +1000 (AEST)
From: Liberman Igal <Igal.Liberman@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Madalin-Cristian Bucur <madalin.bucur@freescale.com>, Shaohui Xie
 <Shaohui.Xie@freescale.com>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v4] powerpc/mpc85xx: Add MDIO bus muxing support to the
 board device tree(s)
Date: Sun, 2 Aug 2015 11:42:25 +0000
Message-ID: <DM2PR03MB509FD00DD1CB7AB0449B5ADE6880@DM2PR03MB509.namprd03.prod.outlook.com>
References: <1438231630-11056-1-git-send-email-igal.liberman@freescale.com>
 <1438287351.2993.369.camel@freescale.com>
In-Reply-To: <1438287351.2993.369.camel@freescale.com>
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
LCAyMDE1IDExOjE2IFBNDQo+IFRvOiBMaWJlcm1hbiBJZ2FsLUIzMTk1MA0KPiBDYzogZGV2aWNl
dHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBCdWN1
cg0KPiBNYWRhbGluLUNyaXN0aWFuLUIzMjcxNjsgWGllIFNoYW9odWktQjIxOTg5OyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjRdIHBvd2VycGMv
bXBjODV4eDogQWRkIE1ESU8gYnVzIG11eGluZyBzdXBwb3J0DQo+IHRvIHRoZSBib2FyZCBkZXZp
Y2UgdHJlZShzKQ0KPiANCj4gT24gVGh1LCAyMDE1LTA3LTMwIGF0IDA3OjQ3ICswMzAwLCBJZ2Fs
LkxpYmVybWFuIHdyb3RlOg0KPiA+IEZyb206IElnYWwgTGliZXJtYW4gPElnYWwuTGliZXJtYW5A
ZnJlZXNjYWxlLmNvbT4NCj4gPg0KPiA+IERlc2NyaWJlIHRoZSBQSFkgdG9wb2xvZ3kgZm9yIGFs
bCBjb25maWd1cmF0aW9ucyBzdXBwb3J0ZWQgYnkgZWFjaA0KPiA+IGJvYXJkDQo+ID4NCj4gPiBC
YXNlZCBvbiBwcmlvciB3b3JrIGJ5IEFuZHkgRmxlbWluZyA8YWZsZW1pbmdAZnJlZXNjYWxlLmNv
bT4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IElnYWwgTGliZXJtYW4gPElnYWwuTGliZXJtYW5A
ZnJlZXNjYWxlLmNvbT4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBTaHJ1dGkgS2FuZXRrYXIgPFNocnV0
aUBmcmVlc2NhbGUuY29tPg0KPiA+IFNpZ25lZC1vZmYtYnk6IEVtaWwgTWVkdmUgPEVtaWxpYW4u
TWVkdmVARnJlZXNjYWxlLmNvbT4NCj4gDQo+IFNpZ25vZmZzIHNob3VsZCBiZSBpbiBjaHJvbm9s
b2dpY2FsIG9yZGVyLiAgWW91IHdlcmUgdGhlIGxhc3QgdG8gdG91Y2gvc3VibWl0DQo+IHRoaXMs
IHNvIHlvdXJzIHNob3VsZCBnbyBsYXN0LiAgTGlrZXdpc2UgaW4gdGhlIG90aGVyIHBhdGNoZXMg
eW91IGp1c3QgcG9zdGVkLg0KPiANCg0KT2ssIEknbGwga2VlcCB0aGUgY29ycmVjdCBvcmRlciwg
dGhhbmtzIGZvciBwb2ludGluZyBvdXQuIA0KDQo+IC1TY290dA0KDQo=
