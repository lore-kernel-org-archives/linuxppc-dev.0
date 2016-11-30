Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out6.electric.net (smtp-out6.electric.net
 [192.162.217.186])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTSlK3ldBzDvx9
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 04:56:13 +1100 (AEDT)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Bjorn Helgaas' <bhelgaas@google.com>, Gavin Shan
 <gwshan@linux.vnet.ibm.com>
CC: "clsoto@us.ibm.com" <clsoto@us.ibm.com>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-pci@vger.kernel.org"
 <linux-pci@vger.kernel.org>
Subject: RE: [PATCH v4 4/7] PCI: Don't update VF BARs while VF memory space
 is enabled
Date: Wed, 30 Nov 2016 17:56:05 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DB02307B5@AcuExch.aculab.com>
References: <20161129035218.21453.93986.stgit@bhelgaas-glaptop.roam.corp.google.com>
 <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
In-Reply-To: <20161129041521.21453.33146.stgit@bhelgaas-glaptop.roam.corp.google.com>
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

RnJvbTogQmpvcm4gSGVsZ2Fhcw0KPiBTZW50OiAyOSBOb3ZlbWJlciAyMDE2IDA0OjE1DQo+IElm
IHdlIHVwZGF0ZSBhIFZGIEJBUiB3aGlsZSBpdCdzIGVuYWJsZWQsIHRoZXJlIGFyZSB0d28gcG90
ZW50aWFsIHByb2JsZW1zOg0KPiANCj4gICAxKSBBbnkgZHJpdmVyIHRoYXQncyB1c2luZyB0aGUg
VkYgaGFzIGEgY2FjaGVkIEJBUiB2YWx1ZSB0aGF0IGlzIHN0YWxlDQo+ICAgICAgYWZ0ZXIgdGhl
IHVwZGF0ZSwgYW5kDQo+IA0KPiAgIDIpIFdlIGNhbid0IHVwZGF0ZSA2NC1iaXQgQkFScyBhdG9t
aWNhbGx5LCBzbyB0aGUgaW50ZXJtZWRpYXRlIHN0YXRlDQo+ICAgICAgKG5ldyBsb3dlciBkd29y
ZCB3aXRoIG9sZCB1cHBlciBkd29yZCkgbWF5IGNvbmZsaWN0IHdpdGggYW5vdGhlcg0KPiAgICAg
IGRldmljZSwgYW5kIGFuIGFjY2VzcyBieSBhIGRyaXZlciB1bnJlbGF0ZWQgdG8gdGhlIFZGIG1h
eSBjYXVzZSBhIGJ1cw0KPiAgICAgIGVycm9yLg0KDQpDYW4gdGhlIGhpZ2ggd29yZCBiZSBmaXJz
dCBzZXQgdG8gYSB2YWx1ZSB0aGF0IGlzIGludmFsaWQgKGllIGEgNEcgYmxvY2sNCnRoYXQgaGFz
IG5vIHZhbGlkIFBDSWUgc2xhdmVzKSBiZWZvcmUgdXBkYXRpbmcgdGhlIGxvdyB3b3JkIGFuZCBm
aW5hbGx5DQp0aGUgY29ycmVjdCBoaWdoIHdvcmQuDQoNCk5vdGUgdGhhdCB0aGUgYWRkcmVzcyBv
bmx5IGhhcyB0byBiZSBvdXRzaWRlIHRoZSByYW5nZSB0aGF0IHRoZSBicmlkZ2UNCmZvcndhcmRz
IG9udG8gdGhhdCBzcGVjaWZpYyBidXMuDQoNCglEYXZpZA0KDQo=
