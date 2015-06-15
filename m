Return-Path: <madalin.bucur@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0147.outbound.protection.outlook.com [207.46.100.147])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0BF241A0E51
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Jun 2015 22:44:28 +1000 (AEST)
From: Madalin-Cristian Bucur <madalin.bucur@freescale.com>
To: Eric Dumazet <eric.dumazet@gmail.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, Jianhua Xie
 <Jianhua.Xie@freescale.com>, "netdev@vger.kernel.org"
 <netdev@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [RFC,v3 02/10] dpaa_eth: add support for DPAA Ethernet
Date: Mon, 15 Jun 2015 12:44:14 +0000
Message-ID: <BL2PR03MB54553C9839048902818ACE2E6B80@BL2PR03MB545.namprd03.prod.outlook.com>
References: <1430319405-31280-1-git-send-email-madalin.bucur@freescale.com>
 <DM2PR0301MB086380B3D89425345562F384F3BD0@DM2PR0301MB0863.namprd03.prod.outlook.com>
 <BL2PR03MB545CA85B1FE886FCD07DE26E6BD0@BL2PR03MB545.namprd03.prod.outlook.com>
 <1433947452.27504.9.camel@edumazet-glaptop2.roam.corp.google.com>
In-Reply-To: <1433947452.27504.9.camel@edumazet-glaptop2.roam.corp.google.com>
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

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBFcmljIER1bWF6ZXQgW21haWx0
bzplcmljLmR1bWF6ZXRAZ21haWwuY29tXQ0KPiANCj4gT24gV2VkLCAyMDE1LTA2LTEwIGF0IDA3
OjM4ICswMDAwLCBNYWRhbGluLUNyaXN0aWFuIEJ1Y3VyIHdyb3RlOg0KPiA+IEhpIEVyaWMsDQo+
ID4NCj4gPiBDYW4geW91IHBsZWFzZSB0ZWxsIHVzIGlmIHRoaXMgY2hhbmdlIHdvdWxkIGJlIGZv
ciB0aGUgYmV0dGVyPw0KPiA+DQo+ID4gSSB3YXMgYWJvdXQgdG8gc2F5IHllcyB0byB0aGlzIHJl
cXVlc3QgYnV0IGNoZWNrZWQgYW5kIG5vIG90aGVyIEV0aGVybmV0DQo+IGRyaXZlciBzZWVtcyB0
byB1c2UgdGhlIHF1ZXVlIHRyYW5zX3N0YXJ0Lg0KPiA+IEkgd2FzIGFibGUgdG8gZmluZCB5b3Vy
IHBhdGNoICJuZXQ6IHR4IHNjYWxhYmlsaXR5IHdvcmtzIDogdHJhbnNfc3RhcnQiIFsNCj4gaHR0
cDovL3BhdGNod29yay5vemxhYnMub3JnL3BhdGNoLzI3MTA0LyBdIGJ1dCBkaWQgbm90IGZpbmQg
bW9yZSBhYm91dCB0aGlzDQo+IHRvcGljLg0KPiA+DQo+IA0KPiBEcml2ZXJzIG5vIGxvbmdlciBo
YXZlIHRvIHdvcnJ5IGFib3V0IHVwZGF0aW5nIHRyYW5zX3N0YXJ0IHRoZW1zZWx2ZXMuDQo+IENv
cmUgbmV0d29ya2luZyBzdGFjayBoYW5kbGVzIHRoaXMuDQo+IA0KPiBDaGVjayB0eHFfdHJhbnNf
dXBkYXRlKCkgZG9uZSBmcm9tIG5ldGRldl9zdGFydF94bWl0KCkNCg0KSSdsbCByZW1vdmUgdGhl
IHVwZGF0ZXMsIHRoYW5rIHlvdS4NCg0KTWFkYWxpbg0K
