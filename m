Return-Path: <r63061@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1E5202C00EA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Sep 2013 19:52:27 +1000 (EST)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V3 1/2] powerpc/85xx: Add QE common init functions
Date: Fri, 6 Sep 2013 09:52:19 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D5D2378@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378312019.12204.21.camel@snotra.buserror.net>
In-Reply-To: <1378312019.12204.21.camel@snotra.buserror.net>
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

SGkgU2NvdHQsDQoNCkkgYWxyZWFkeSByZW1vdmUgdGhlc2UgY29kZSBmcm9tIHRoZSBQMTAyNVRX
UiBwbGF0Zm9ybSBmaWxlKHNlZSB0aGUgMi8yIHBhdGNoKS4gRG8geW91IG1lYW5zIEkgYWxzbyBu
ZWVkIHRvIHJlbW92ZSB0aGVzZSBjb2RlcyBmcm9tIHRoZSBvdGhlcnMgcGxhdGZvcm1zIGFuZCB1
c2UgdGhlIGNvbW1vbiBjYWxsIGluc3RlYWQ/IA0KVGhhbmsgeW91Lg0KDQpCZXN0IFJlZ2FyZHMN
ClhpZSBYaWFvYm8NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQpGcm9tOiBXb29kIFNjb3R0
LUIwNzQyMSANClNlbnQ6IFRodXJzZGF5LCBTZXB0ZW1iZXIgMDUsIDIwMTMgMTI6MjcgQU0NClRv
OiBYaWUgWGlhb2JvLVI2MzA2MQ0KQ2M6IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMub3JnOyBn
YWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnDQpTdWJqZWN0OiBSZTogW1BBVENIIFYzIDEvMl0gcG93
ZXJwYy84NXh4OiBBZGQgUUUgY29tbW9uIGluaXQgZnVuY3Rpb25zDQoNCk9uIE1vbiwgMjAxMy0w
OS0wMiBhdCAxODoxMSArMDgwMCwgWGllIFhpYW9ibyB3cm90ZToNCj4gRGVmaW5lIHR3byBRRSBp
bml0IGZ1bmN0aW9ucyBpbiBjb21tb24gZmlsZSwgYW5kIGF2b2lkIHRoZSBzYW1lIGNvZGVzIA0K
PiBiZWluZyBkdXBsaWNhdGVkIGluIGJvYXJkIGZpbGVzLg0KPiANCj4gU2lnbmVkLW9mZi1ieTog
WGllIFhpYW9ibyA8WC5YaWVAZnJlZXNjYWxlLmNvbT4NCj4gLS0tDQo+IFYzIC0+IFYyOiBOb2No
YW5nZQ0KPiANCj4gIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvODV4eC9jb21tb24uYyAgfCA0NyAN
Cj4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gIGFyY2gvcG93ZXJwYy9w
bGF0Zm9ybXMvODV4eC9tcGM4NXh4LmggfCAgOCArKysrKysNCj4gIDIgZmlsZXMgY2hhbmdlZCwg
NTUgaW5zZXJ0aW9ucygrKQ0KDQpEb24ndCBqdXN0IGNvcHkgaXQ7IHJlbW92ZSBpdCBmcm9tIHRo
ZSBwbGFjZSB5b3UgY29waWVkIGZyb20gYW5kIGhhdmUgdGhhdCBjb2RlIGNhbGwgdGhlIGNvbW1v
biB2ZXJzaW9uLg0KDQotU2NvdHQNCg0KDQo=
