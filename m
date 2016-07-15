Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rrW362S16zDqFR
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 21:45:22 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Aneesh Kumar K.V' <aneesh.kumar@linux.vnet.ibm.com>,
 "benh@kernel.crashing.org" <benh@kernel.crashing.org>, "paulus@samba.org"
 <paulus@samba.org>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
CC: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: RE: [PATCH for-4.8 03/12] powerpc/mm: use _raw variant of page
 table accessors
Date: Fri, 15 Jul 2016 11:42:51 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4F8E51@AcuExch.aculab.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1468402531-4914-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1468402531-4914-4-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

RnJvbTogQW5lZXNoIEt1bWFyIEsuVg0KPiBTZW50OiAxMyBKdWx5IDIwMTYgMTA6MzUNCj4gDQo+
IFRoaXMgc3dpdGNoIGZldyBvZiB0aGUgcGFnZSB0YWJsZSBhY2Nlc3NvciB0byB1c2UgdGhlIF9f
cmF3IHZhcmlhbnQNCj4gYW5kIGRvZXMgdGhlIGNwdSB0byBiaWcgZW5kaWFuIGNvbnZlcnNpb24g
b2YgY29uc3RhbnRzLiBUaGlzIGhlbHBzIGluDQo+IGdlbmVyYXRpbmcgYmV0dGVyIGNvZGUuDQoN
Ckl0IG1pZ2h0IGJlIGJldHRlciB0byBzYXkgdGhhdCBjaGVja3MgZm9yIGEgdmFsdWUgYmVpbmcg
MCBkb24ndCBkZXBlbmQNCm9uIHRoZSBlbmRpYW5uZXNzLg0KDQpJbiB3aGljaCBjYXNlIHlvdSB3
YW50IGEgZnVuY3Rpb24gdGhhdCByZXR1cm4gISF4eHhfcmF3KCkgaXRzZWxmLg0KDQpPVE9IIGl0
IG1pZ2h0IGJlIHdvcnRoIGZpbmRpbmcgb3V0IHdoeSB0aGUgY3B1J3MgYnl0ZXN3YXBwaW5nIG1l
bW9yeQ0KYWNjZXNzb3JzIGFyZW4ndCB1c2VkIC0gd2hpY2ggbWlnaHQgc2F2ZSB0aGUgYnl0ZXN3
YXAgaW5zdHJ1Y3Rpb24NCnNlcXVlbmNlIGluIGFsbCBwYXRocy4NCg0KCURhdmlkDQoNCg==
