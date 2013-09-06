Return-Path: <r63061@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe006.messaging.microsoft.com [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A3B912C00F8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 20:01:37 +1000 (EST)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
Date: Fri, 6 Sep 2013 10:01:18 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
 <1378311953.12204.20.camel@snotra.buserror.net>
In-Reply-To: <1378311953.12204.20.camel@snotra.buserror.net>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: Johnston Michael-R49610 <r49610@freescale.com>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

SGkgU2NvdHQsDQoNClRoYW5rcyBmb3IgeW91ciByZW1pbmRpbmcgYW5kIGFkdmljZS4NCg0KSSBk
aXNjdXNzIHRoaXMgd2l0aCBMaXUgU2hlbmd6aG91KHRoZSBmaXJzdCBwZXJzb24gdGhhdCByZW1p
bmQgbWUgI2ludGVycnVwdC1jZWxscyBpcyA0KSwgaGUgYWR2aXNlZCByZW1vdmluZyB0aGUgaW50
ZXJydXB0cyBwcm9wZXJ0eSBmcm9tIHRoZSBwaHkgbm9kZSwgYmVjYXVzZSB0aGUgbWRpbyB1c2Vk
IHRoZSBwb2xsIHdheSBwcmVmZXJlbnRpYWxseS4NCg0KQmVzdCBSZWdhcmRzDQpYaWUgWGlhb2Jv
DQoNCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXb29kIFNjb3R0LUIwNzQyMSAN
ClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMDUsIDIwMTMgMTI6MjYgQU0NClRvOiBYaWUgWGlh
b2JvLVI2MzA2MQ0KQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBnYWxha0BrZXJu
ZWwuY3Jhc2hpbmcub3JnOyBKb2huc3RvbiBNaWNoYWVsLVI0OTYxMA0KU3ViamVjdDogUmU6IFtQ
QVRDSCBWMyAyLzJdIHBvd2VycGMvODV4eDogQWRkIFRXUi1QMTAyNSBib2FyZCBzdXBwb3J0DQoN
Ck9uIE1vbiwgMjAxMy0wOS0wMiBhdCAxODoxMSArMDgwMCwgWGllIFhpYW9ibyB3cm90ZToNCj4g
KyZzb2Mgew0KPiArCXVzYkAyMjAwMCB7DQo+ICsJCXBoeV90eXBlID0gInVscGkiOw0KPiArCX07
DQo+ICsNCj4gKwltZGlvQDI0MDAwIHsNCj4gKwkJcGh5MDogZXRoZXJuZXQtcGh5QDIgew0KPiAr
CQkJaW50ZXJydXB0LXBhcmVudCA9IDwmbXBpYz47DQo+ICsJCQlpbnRlcnJ1cHRzID0gPDEgMT47
DQo+ICsJCQlyZWcgPSA8MHgyPjsNCj4gKwkJfTsNCj4gKw0KPiArCQlwaHkxOiBldGhlcm5ldC1w
aHlAMSB7DQo+ICsJCQlpbnRlcnJ1cHQtcGFyZW50ID0gPCZtcGljPjsNCj4gKwkJCWludGVycnVw
dHMgPSA8MiAxPjsNCj4gKwkJCXJlZyA9IDwweDE+Ow0KPiArCQl9Ow0KDQpBZ2FpbiwgI2ludGVy
cnVwdC1jZWxscyBpcyA0Lg0KDQpQbGVhc2UgcmVzcG9uZCB0byBmZWVkYmFjayByYXRoZXIgdGhh
biBpZ25vcmluZyBpdCBhbmQgcmVwb3N0aW5nIHRoZSBzYW1lIHRoaW5nIHdpdGhvdXQgY29tbWVu
dC4NCg0KLVNjb3R0DQoNCg0K
