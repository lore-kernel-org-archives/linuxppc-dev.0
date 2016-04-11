Return-Path: <zhiqiang.hou@nxp.com>
Received: from emea01-db3-obe.outbound.protection.outlook.com
 (mail-db3on0055.outbound.protection.outlook.com [157.55.234.55])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qjzRK5rg4zDqBs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Apr 2016 15:39:57 +1000 (AEST)
From: Zhiqiang Hou <zhiqiang.hou@nxp.com>
To: David Laight <David.Laight@ACULAB.COM>, Scott Wood <oss@buserror.net>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCH] powerpc/config: Disable the 4KiB erase granularity of SPI
 flash
Date: Mon, 11 Apr 2016 05:25:10 +0000
Message-ID: <AM4PR04MB2148DC5CA7B8D5053AC647B584940@AM4PR04MB2148.eurprd04.prod.outlook.com>
References: <1459937676-25668-1-git-send-email-Zhiqiang.Hou@nxp.com>
 <1459980089.32510.78.camel@buserror.net>
 <AM4PR04MB21485158542FA13151D6B23484900@AM4PR04MB2148.eurprd04.prod.outlook.com>
 <063D6719AE5E284EB5DD2968C1650D6D54DC814C@AcuExch.aculab.com>
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D54DC814C@AcuExch.aculab.com>
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

SGkgRGF2aWQsDQoNClRoYW5rcyBmb3IgeW91ciBjb21tZW50cy4NCg0KPiAtLS0tLU9yaWdpbmFs
IE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBEYXZpZCBMYWlnaHQgW21haWx0bzpEYXZpZC5MYWlnaHRA
QUNVTEFCLkNPTV0NCj4gU2VudDogMjAxNuW5tDTmnIg55pelIDA6MDENCj4gVG86IFpoaXFpYW5n
IEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBTY290dCBXb29kIDxvc3NAYnVzZXJyb3IubmV0
PjsNCj4gbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGJlbmhAa2VybmVsLmNyYXNoaW5n
Lm9yZzsgcGF1bHVzQHNhbWJhLm9yZzsNCj4gbXBlQGVsbGVybWFuLmlkLmF1DQo+IENjOiBNaW5n
a2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+DQo+IFN1YmplY3Q6IFJFOiBbUEFUQ0hdIHBvd2Vy
cGMvY29uZmlnOiBEaXNhYmxlIHRoZSA0S2lCIGVyYXNlIGdyYW51bGFyaXR5IG9mIFNQSQ0KPiBm
bGFzaA0KPiANCj4gRnJvbTogWmhpcWlhbmcgSG91DQo+ID4gU2VudDogMDcgQXByaWwgMjAxNiAw
NDoxNw0KPiAuLi4NCj4gPiA+IElzIHRoZXJlIGEgcmVhc29uIHNwZWNpZmljIHRvIDg1eHggdG8g
aGF2ZSBhIGRpZmZlcmVudCBkZWZhdWx0IHRoYW4NCj4gPiA+IGV2ZXJ5IG90aGVyIHBsYXRmb3Jt
IGV4Y2VwdCBscGMxOHh4PyAgVGhlIGRlc2NyaXB0aW9uIG9mDQo+ID4gPiBNVERfU1BJX05PUl9V
U0VfNEtfU0VDVE9SUyBhY2tub3dsZWRnZXMgdGhhdCBlcmFzZSBzcGVlZCBpcyBhDQo+ID4gPiB0
cmFkZW9mZi4gIFdoeSBpcyB0aGF0IGNvbmNlcm4gbW9yZSBjb21wZWxsaW5nIG9uIDg1eHggdGhh
biBlbHNld2hlcmU/DQo+ID4gPg0KPiA+DQo+ID4gSSBkb24ndCB3YW50IHRvIHNwZWNpZnkgODV4
eCwgYnV0IGNvbmZpZ3Mgb2YgZnNsLiBJJ20gc3RpbGwgY29uZnVzaW5nDQo+ID4gYWJvdXQgc28g
bWFueSBjb25maWdzLiBXaWxsIGFkZCBvdGhlciBwbGF0Zm9ybXMgaWYgbmVjZXNzYXJ5Lg0KPiA+
DQo+ID4gRm9yIHRoaXMgcGF0Y2gsIGl0IHRha2VzIGFib3V0IDEzIG1pbnMgdG8gZXJhc2UgNjRN
aUIgYnkgc3Vic2VjdG9yDQo+ID4gZXJhc2UgY29tbWFuZCAoNEtpQiBwZXIgdGltZSksIGJ1dCB0
YWtlcyAyIG1pbnMgYnkgc2VjdG9yIGVyYXNlDQo+ID4gY29tbWFuZCg2NEtpQiBwZXIgdGltZSku
IEl0IGlzIGNvbnNwaWN1b3VzIGRlY3JlYXNlLiBXaHkgaXQgdXNlcyB0aGUNCj4gPiA0S2lCIGdy
YW51bGFyaXR5IGJ5IGRlZmF1bHQsIHdoYXQncyB0aGUgYmVuZWZpdD8NCj4gDQo+IFNob3VsZCBp
dCBiZSBkb2luZyA2NEsgZXJhc2VzIGZvbGxvd2VkIGJ5IDAgdG8gMTUgNEsgZXJhc2VzIGZvciBh
bnkgZmluYWwgZnJhZ21lbnQ/DQoNCldoZW4gd2lsbCB0aGlzIHNpdHVhdGlvbiBjb21lIHVwPw0K
DQpUaGFua3MsDQpaaGlxaWFuZw0KDQo=
