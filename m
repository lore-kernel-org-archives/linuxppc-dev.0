Return-Path: <r63061@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe003.messaging.microsoft.com [207.46.163.26])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 767442C011E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 19:29:10 +1000 (EST)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V3 2/2] powerpc/85xx: Add TWR-P1025 board support
Date: Tue, 10 Sep 2013 09:28:59 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D5D5DC5@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378116699-18826-2-git-send-email-X.Xie@freescale.com>
 <1378311953.12204.20.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5D23CE@039-SN1MPN1-003.039d.mgd.msft.net>
 <1378481146.12204.183.camel@snotra.buserror.net>
In-Reply-To: <1378481146.12204.183.camel@snotra.buserror.net>
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

SGkgU2NvdHQsDQoNCkkgZGlzY3VzcyBpdCB3aXRoIExpdSBTaGVuZ3pob3UgYWdhaW4uIEkgdHJp
ZWQgaW50ZXJydXB0cyA9IDwxIDEgMCAwPiBpbnN0ZWFkIG9mIGludGVycnVwdHMgPSA8MSAxPiBv
biBQMTAyNVRXUiwgYW5kIGl0J3MgT0suIFNvIEkgd2lsbCBhZGQgMiBjZWxscyBmb3IgdGhlIGlu
dGVycnVwdHMgcHJvcGVydHkuIFRoYW5rIHlvdS4NCg0KQmVzdCBSZWdhcmRzDQpYaWUgWGlhb2Jv
DQotLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KRnJvbTogV29vZCBTY290dC1CMDc0MjEgDQpT
ZW50OiBGcmlkYXksIFNlcHRlbWJlciAwNiwgMjAxMyAxMToyNiBQTQ0KVG86IFhpZSBYaWFvYm8t
UjYzMDYxDQpDYzogV29vZCBTY290dC1CMDc0MjE7IGxpbnV4cHBjLWRldkBsaXN0cy5vemxhYnMu
b3JnOyBnYWxha0BrZXJuZWwuY3Jhc2hpbmcub3JnOyBKb2huc3RvbiBNaWNoYWVsLVI0OTYxMA0K
U3ViamVjdDogUmU6IFtQQVRDSCBWMyAyLzJdIHBvd2VycGMvODV4eDogQWRkIFRXUi1QMTAyNSBi
b2FyZCBzdXBwb3J0DQoNCk9uIEZyaSwgMjAxMy0wOS0wNiBhdCAwNTowMSAtMDUwMCwgWGllIFhp
YW9iby1SNjMwNjEgd3JvdGU6DQo+IEhpIFNjb3R0LA0KPiANCj4gVGhhbmtzIGZvciB5b3VyIHJl
bWluZGluZyBhbmQgYWR2aWNlLg0KPiANCj4gSSBkaXNjdXNzIHRoaXMgd2l0aCBMaXUgU2hlbmd6
aG91KHRoZSBmaXJzdCBwZXJzb24gdGhhdCByZW1pbmQgbWUgDQo+ICNpbnRlcnJ1cHQtY2VsbHMg
aXMgNCksIGhlIGFkdmlzZWQgcmVtb3ZpbmcgdGhlIGludGVycnVwdHMgcHJvcGVydHkgDQo+IGZy
b20gdGhlIHBoeSBub2RlLCBiZWNhdXNlIHRoZSBtZGlvIHVzZWQgdGhlIHBvbGwgd2F5IHByZWZl
cmVudGlhbGx5Lg0KDQpJIGRvbid0IGZvbGxvdy4uLiBpZiB0aGUgUEhZcyBoYXZlIGludGVycnVw
dHMsIHdoeSB3b3VsZCB3ZSBwcmVmZXIgdG8gcG9sbD8NCg0KSW4gYW55IGNhc2UsIHRoZSBkZXZp
Y2UgdHJlZSBkZXNjcmliZXMgdGhlIGhhcmR3YXJlLCBub3QgaG93IHlvdSdkIHByZWZlciB0byB1
c2UgaXQuDQoNCi1TY290dA0KDQoNCg==
