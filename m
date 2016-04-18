Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.190])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qpQvc2cM3zDq5f
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 21:31:23 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yongji Xie' <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "iommu@lists.linux-foundation.org"
 <iommu@lists.linux-foundation.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
CC: "alistair@popple.id.au" <alistair@popple.id.au>,
 "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
 "zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>,
 "eric.auger@linaro.org" <eric.auger@linaro.org>, "aik@ozlabs.ru"
 <aik@ozlabs.ru>, "joro@8bytes.org" <joro@8bytes.org>, "will.deacon@arm.com"
 <will.deacon@arm.com>, "gwshan@linux.vnet.ibm.com"
 <gwshan@linux.vnet.ibm.com>, "warrier@linux.vnet.ibm.com"
 <warrier@linux.vnet.ibm.com>, "alex.williamson@redhat.com"
 <alex.williamson@redhat.com>, "paulus@samba.org" <paulus@samba.org>,
 "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [RFC v6 06/10] PCI: Add a new PCI_BUS_FLAGS_MSI_REMAP flag
Date: Mon, 18 Apr 2016 11:30:07 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D5F4A45A8@AcuExch.aculab.com>
References: <1460977120-29367-1-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1460977120-29367-1-git-send-email-xyjxie@linux.vnet.ibm.com>
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

RnJvbTogWW9uZ2ppIFhpZQ0KPiBTZW50OiAxOCBBcHJpbCAyMDE2IDExOjU5DQo+IFdlIGludHJv
ZHVjZSBhIG5ldyBwY2lfYnVzX2ZsYWdzLCBQQ0lfQlVTX0ZMQUdTX01TSV9SRU1BUA0KPiB3aGlj
aCBpbmRpY2F0ZXMgYWxsIGRldmljZXMgb24gdGhlIGJ1cyBhcmUgcHJvdGVjdGVkIGJ5IHRoZQ0K
PiBoYXJkd2FyZSB3aGljaCBzdXBwb3J0cyBJUlEgcmVtYXBwaW5nKGludGVsIG5hbWluZykuDQo+
IA0KPiBUaGlzIGZsYWcgd2lsbCBiZSB1c2VkIHRvIGtub3cgd2hldGhlciBpdCdzIHNhZmUgdG8g
ZXhwb3NlDQo+IE1TSS1YIHRhYmxlcyBvZiBQQ0kgQkFScyB0byB1c2Vyc3BhY2UuIEJlY2F1c2Ug
dGhlIGNhcGFiaWxpdHkNCj4gb2YgSVJRIHJlbWFwcGluZyBjYW4gZ3VhcmFudGVlIHRoZSBQQ0kg
ZGV2aWNlIGNhbm5vdCB0cmlnZ2VyDQo+IE1TSXMgdGhhdCBjb3JyZXNwb25kIHRvIGludGVycnVw
dCBJRHMgb2Ygb3RoZXIgZGV2aWNlcy4NCg0KSSdtIHdvcnJpZWQgdGhhdCB0aGlzIGVudGlyZSBz
ZXJpZXMgaXMgZ29pbmcgdG8gYnJlYWsgZHJpdmVycw0KZm9yIGV4aXN0aW5nIGhhcmR3YXJlLg0K
DQpJIHVuZGVyc3RhbmQgc29tZSBvZiB0aGUgcmVhc29uaW5nIGZvciAndm0gcGFzcyB0aHJvdWdo
JyBjb25maWd1cmF0aW9ucywNCmJ1dCB0aGVyZSB3aWxsIGJlIFBDSWUgZGV2aWNlcyBvdXQgdGhl
cmUgdGhhdCBoYXZlIHRoZSBNU0ktWCB0YWJsZXMNCmluIHRoZSBzYW1lIEJBUiBhcyBvdGhlciBk
ZXZpY2UgcmVnaXN0ZXJzLg0KSWYgeW91IGFyZSBsdWNreSBub3RoaW5nIGVsc2UgaXMgaW4gdGhl
IHNhbWUgNGsgYXJlYSwgYnV0IEkgd291bGRuJ3QNCmFzc3VtZSBpdC4NCg0KSW4gYW55IGNhc2Us
IGlmIHRoZSBoYXJkd2FyZSBjYW4ndCBwb2xpY2UgdGhlIGNhcmQncyBtYXN0ZXIgdHJhbnNmZXJz
DQp0aGVyZSBpcyBub3RoaW5nIHRvIHN0b3AgYSBkaWZmZXJlbnQgYnVzIG1hc3RlciBibG9jayBv
biB0aGUgY2FyZA0KZnJvbSByYWlzaW5nIE1TSS1YIGludGVycnVwdHMgLSB0aGV5IGFyZSBqdXN0
IGEgUENJZSB3cml0ZS4NClNvIGFsbCB5b3UgYXJlIGRvaW5nIGlzIHJhaXNpbmcgdGhlIGJhciBz
bGlnaHRseSBhbmQgZ2l2aW5nIGEgdmVyeSBmYWxzZQ0Kc2Vuc2Ugb2Ygc2VjdXJpdHkuDQoNCglE
YXZpZA0KDQo=
