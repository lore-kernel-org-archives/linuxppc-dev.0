Return-Path: <r63061@freescale.com>
Received: from db9outboundpool.messaging.microsoft.com
 (mail-db9lp0249.outbound.messaging.microsoft.com [213.199.154.249])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5B64E2C0167
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Sep 2013 18:55:33 +1000 (EST)
From: Xie Xiaobo-R63061 <r63061@freescale.com>
To: Wood Scott-B07421 <B07421@freescale.com>
Subject: RE: [PATCH V3 1/2] powerpc/85xx: Add QE common init functions
Date: Tue, 10 Sep 2013 08:55:22 +0000
Message-ID: <69EC9ED88E3CC04094A78F8074A7986D5D5D42@039-SN1MPN1-003.039d.mgd.msft.net>
References: <1378116699-18826-1-git-send-email-X.Xie@freescale.com>
 <1378312019.12204.21.camel@snotra.buserror.net>
 <69EC9ED88E3CC04094A78F8074A7986D5D2378@039-SN1MPN1-003.039d.mgd.msft.net>
 <1378481093.12204.182.camel@snotra.buserror.net>
In-Reply-To: <1378481093.12204.182.camel@snotra.buserror.net>
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

SGksDQoNClRoYW5rIHlvdSB2ZXJ5IG11Y2guIEkgd2lsbCBzdWJtaXQgdXBkYXRlZCBwYXRjaCBz
b29uLg0KDQpCZXN0IFJlZ2FyZHMNClhpZSBYaWFvYm8NCi0tLS0tT3JpZ2luYWwgTWVzc2FnZS0t
LS0tDQpGcm9tOiBXb29kIFNjb3R0LUIwNzQyMSANClNlbnQ6IEZyaWRheSwgU2VwdGVtYmVyIDA2
LCAyMDEzIDExOjI1IFBNDQpUbzogWGllIFhpYW9iby1SNjMwNjENCkNjOiBXb29kIFNjb3R0LUIw
NzQyMTsgbGludXhwcGMtZGV2QGxpc3RzLm96bGFicy5vcmc7IGdhbGFrQGtlcm5lbC5jcmFzaGlu
Zy5vcmcNClN1YmplY3Q6IFJlOiBbUEFUQ0ggVjMgMS8yXSBwb3dlcnBjLzg1eHg6IEFkZCBRRSBj
b21tb24gaW5pdCBmdW5jdGlvbnMNCg0KT24gRnJpLCAyMDEzLTA5LTA2IGF0IDA0OjUyIC0wNTAw
LCBYaWUgWGlhb2JvLVI2MzA2MSB3cm90ZToNCj4gSGkgU2NvdHQsDQo+IA0KPiBJIGFscmVhZHkg
cmVtb3ZlIHRoZXNlIGNvZGUgZnJvbSB0aGUgUDEwMjVUV1IgcGxhdGZvcm0gZmlsZShzZWUgdGhl
IDIvMiBwYXRjaCkuIERvIHlvdSBtZWFucyBJIGFsc28gbmVlZCB0byByZW1vdmUgdGhlc2UgY29k
ZXMgZnJvbSB0aGUgb3RoZXJzIHBsYXRmb3JtcyBhbmQgdXNlIHRoZSBjb21tb24gY2FsbCBpbnN0
ZWFkPyANCj4gVGhhbmsgeW91Lg0KDQpZZXMuDQoNCi1TY290dA0KDQoNCg==
