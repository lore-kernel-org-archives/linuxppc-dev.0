Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.182])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 112A71A08A6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 16 Jan 2016 04:27:39 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Yongji Xie' <xyjxie@linux.vnet.ibm.com>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-doc@vger.kernel.org"
 <linux-doc@vger.kernel.org>
CC: "nikunj@linux.vnet.ibm.com" <nikunj@linux.vnet.ibm.com>,
 "zhong@linux.vnet.ibm.com" <zhong@linux.vnet.ibm.com>, "corbet@lwn.net"
 <corbet@lwn.net>, "aik@ozlabs.ru" <aik@ozlabs.ru>,
 "warrier@linux.vnet.ibm.com" <warrier@linux.vnet.ibm.com>,
 "alex.williamson@redhat.com" <alex.williamson@redhat.com>, "paulus@samba.org"
 <paulus@samba.org>, "bhelgaas@google.com" <bhelgaas@google.com>
Subject: RE: [RFC PATCH v3 3/5] PCI: Add host bridge attribute to indicate
 filtering of MSIs is supported
Date: Fri, 15 Jan 2016 17:24:22 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6D1CCC6833@AcuExch.aculab.com>
References: <1452841574-2781-1-git-send-email-xyjxie@linux.vnet.ibm.com>
 <1452841574-2781-4-git-send-email-xyjxie@linux.vnet.ibm.com>
In-Reply-To: <1452841574-2781-4-git-send-email-xyjxie@linux.vnet.ibm.com>
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

RnJvbTogWW9uZ2ppIFhpZQ0KPiBTZW50OiAxNSBKYW51YXJ5IDIwMTYgMDc6MDYNCj4NCj4gTVNJ
LVggdGFibGVzIGFyZSBub3QgYWxsb3dlZCB0byBiZSBtbWFwcGVkIGluIHZmaW8tcGNpDQo+IGRy
aXZlciBpbiBjYXNlIHRoYXQgdXNlciBnZXQgdG8gdG91Y2ggdGhpcyBkaXJlY3RseS4NCj4gVGhp
cyB3aWxsIGNhdXNlIHNvbWUgcGVyZm9ybWFuY2UgaXNzdWVzIHdoZW4gd2hlbiBQQ0kNCj4gYWRh
cHRlcnMgaGF2ZSBjcml0aWNhbCByZWdpc3RlcnMgaW4gdGhlIHNhbWUgcGFnZSBhcw0KPiB0aGUg
TVNJLVggdGFibGUuDQouLi4NCklmIHRoZSBkcml2ZXIgd2FudHMgdG8gZ2VuZXJhdGUgYW4gaW5j
b3JyZWN0IE1TSS1YIGludGVycnVwdA0KaXQgY2FuIGRvIHNvIGJ5IHJlcXVlc3RpbmcgdGhlIGRl
dmljZSBkbyBhIG5vcm1hbCBtZW1vcnkgdHJhbnNmZXINCnRvIHRoZSB0YXJnZXQgYWRkcmVzcyBh
cmVhIHRoYXQgcmFpc2VzIE1TSS1YIGludGVycnVwdHMuDQpTbyBkaXNhYmxpbmcgd3JpdGVzIHRv
IHRoZSBNU0ktWCB0YWJsZSAoYW5kIHBlbmRpbmcgYml0IGFycmF5KQ0KYXJlYXMgb25seSByYWlz
ZXMgdGhlIGJhciB2ZXJ5IHNsaWdodGx5Lg0KQSBkZXZpY2UgbWF5IGFsc28gZ2l2ZSB0aGUgZHJp
dmVyIHdyaXRlIGFjY2VzcyB0byB0aGUgTVNJLVgNCnRhYmxlIHRocm91Z2ggb3RoZXIgYWRkcmVz
c2VzLg0KDQpUaGlzIHNlZW1zIHRvIG1ha2UgZGlzYWxsb3dpbmcgdGhlIG1hcHBpbmcgb2YgdGhl
IE1TSS1YIHRhYmxlDQpyYXRoZXIgcG9pbnRsZXNzLg0KDQpJJ3ZlIGFsc28gZHVtcGVkIG91dCB0
aGUgTVNJLVggdGFibGUgKGR1cmluZyBkZXZlbG9wbWVudCkgdG8NCmNoZWNrIHRoYXQgdGhlIHZh
bHVlcyBhcmUgYmVpbmcgd3JpdHRlbiB0aGVyZSBjb3JyZWN0bHkuDQoNCglEYXZpZA0KDQo=
