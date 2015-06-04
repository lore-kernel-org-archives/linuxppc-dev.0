Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0115.outbound.protection.outlook.com [157.56.110.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C2B0B1A004D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 15:56:55 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: Scott Wood <scottwood@freescale.com>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>, "Xiaobo
 Xie" <X.Xie@freescale.com>
Subject: RE: [PATCH 2/2] rheap: move rheap.c from arch/powerpc/lib/ to lib/
Date: Thu, 4 Jun 2015 05:56:48 +0000
Message-ID: <SN1PR0301MB15500729CC3A65394FED67389BB30@SN1PR0301MB1550.namprd03.prod.outlook.com>
References: <1432717920-43563-1-git-send-email-B45475@freescale.com>
 <1432717920-43563-2-git-send-email-B45475@freescale.com>
 <1432748213.4089.23.camel@freescale.com>
In-Reply-To: <1432748213.4089.23.camel@freescale.com>
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

T24gVGh1LCAyMDE1LTA1LTI4IGF0IDE6MzdBTSArMDgwMCwgV29vZCBTY290dCB3cm90ZToNCg0K
DQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IFdvb2QgU2NvdHQtQjA3NDIx
DQo+IFNlbnQ6IFRodXJzZGF5LCBNYXkgMjgsIDIwMTUgMTozNyBBTQ0KPiBUbzogWmhhbyBRaWFu
Zy1CNDU0NzUNCj4gQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBXb29kIFNjb3R0
LUIwNzQyMTsgWGllIFhpYW9iby1SNjMwNjENCj4gU3ViamVjdDogUmU6IFtQQVRDSCAyLzJdIHJo
ZWFwOiBtb3ZlIHJoZWFwLmMgZnJvbSBhcmNoL3Bvd2VycGMvbGliLyB0bw0KPiBsaWIvDQo+IA0K
PiBPbiBXZWQsIDIwMTUtMDUtMjcgYXQgMTc6MTIgKzA4MDAsIFpoYW8gUWlhbmcgd3JvdGU6DQo+
ID4gcWUgbmVlZCB0byB1c2UgdGhlIHJoZWFwLCBzbyBtb3ZlIGl0IHRvIHB1YmxpYyBkaXJlY3Rv
cnkuDQo+IA0KPiBZb3UndmUgYmVlbiBwcmV2aW91c2x5IGFza2VkIHRvIHVzZSBsaWIvZ2VuYWxs
b2MuYyByYXRoZXIgdGhhbiBpbnRyb2R1Y2UNCj4gZHVwbGljYXRlIGZ1bmN0aW9uYWxpdHkgaW50
byAvbGliLiAgTkFDSy4NCg0KQ2FuJ3QgdXNlIGxpYi9nZW5hbGxvYy5jIGluc3RlYWQgb2Ygcmhl
YXAuYy4NClFlIG5lZWQgdG8gYWxsb2MgbXVyYW0gb2YgcWUsIG5vdCBESU1NLg0KDQo+IA0KPiBB
bHNvLCBwbGVhc2UgZG9uJ3QgdXNlIGNvcmVpZC1iYXNlZCBlLW1haWwgYWRkcmVzc2VzIHdpdGgg
bm8gcmVhbCBuYW1lcw0KPiBhc3NvY2lhdGVkLCB3aGljaCBtYWtlcyBpdCBoYXJkIHRvIHRlbGwg
d2hvIGhhcyBiZWVuIENDZWQuDQo+IA0KPiAtU2NvdHQNCkJlc3QgUmVnYXJkcw0KWmhhbyBRaWFu
Zw0K
