Return-Path: <Bart.VanAssche@wdc.com>
Received: from esa6.hgst.iphmx.com (esa6.hgst.iphmx.com [216.71.154.45])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xXbjV3NDSzDrGp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Aug 2017 03:21:18 +1000 (AEST)
From: Bart Van Assche <Bart.VanAssche@wdc.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "abdhalee@linux.vnet.ibm.com" <abdhalee@linux.vnet.ibm.com>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "hch@lst.de" <hch@lst.de>, "brking@linux.vnet.ibm.com"
 <brking@linux.vnet.ibm.com>, "sfr@canb.auug.org.au" <sfr@canb.auug.org.au>,
 "sachinp@linux.vnet.ibm.com" <sachinp@linux.vnet.ibm.com>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>, "hare@suse.com"
 <hare@suse.com>, "mpe@ellerman.id.au" <mpe@ellerman.id.au>
Subject: Re: [BUG][bisected 270065e] linux-next fails to boot on powerpc
Date: Wed, 16 Aug 2017 17:21:14 +0000
Message-ID: <1502904072.2421.3.camel@wdc.com>
References: <1502902815.3305.22.camel@abdul.in.ibm.com>
In-Reply-To: <1502902815.3305.22.camel@abdul.in.ibm.com>
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

T24gV2VkLCAyMDE3LTA4LTE2IGF0IDIyOjMwICswNTMwLCBBYmR1bCBIYWxlZW0gd3JvdGU6DQo+
IEFzIG9mIG5leHQtMjAxNzA4MDksIGxpbnV4LW5leHQgb24gcG93ZXJwYyBib290IGh1bmcgd2l0
aCBiZWxvdyB0cmFjZQ0KPiBtZXNzYWdlLg0KPiANCj4gWyAuLi4gXQ0KPiANCj4gQSBiaXNlY3Rp
b24gcmVzdWx0ZWQgaW4gZmlyc3QgYmFkIGNvbW1pdCAoMjcwMDY1ZTkyIC0gc2NzaTogc2NzaS1t
cToNCj4gQWx3YXlzIHVucHJlcGFyZSAuLi4pIGluIHRoZSBtZXJnZSBicmFuY2ggJ3Njc2kvZm9y
LW5leHQnDQo+IA0KPiBTeXN0ZW0gYm9vdGVkIGZpbmUgd2hlbiB0aGUgYmVsb3cgY29tbWl0IGlz
IHJldmVydGVkOiANCj4gDQo+IGNvbW1pdCAyNzAwNjVlOTJjMzE3ODQ1ZDY5MDk1ZWM4ZTNkMTg2
MTZiNWIzOWQ1DQo+IEF1dGhvcjogQmFydCBWYW4gQXNzY2hlIDxiYXJ0LnZhbmFzc2NoZUB3ZGMu
Y29tPg0KPiBEYXRlOiAgIFRodSBBdWcgMyAxNDo0MDoxNCAyMDE3IC0wNzAwDQo+IA0KPiAgICAg
c2NzaTogc2NzaS1tcTogQWx3YXlzIHVucHJlcGFyZSBiZWZvcmUgcmVxdWV1aW5nIGEgcmVxdWVz
dA0KDQpIZWxsbyBCcmlhbiBhbmQgTWljaGFlbCwNCg0KRG8geW91IGFncmVlIHRoYXQgdGhpcyBw
cm9iYWJseSBpbmRpY2F0ZXMgYSBidWcgaW4gdGhlIFBvd2VyUEMgYmxvY2sgZHJpdmVyDQp0aGF0
IGlzIHVzZWQgdG8gYWNjZXNzIHRoZSBib290IGRpc2s/IEFueXdheSwgc2luY2UgYSBzb2x1dGlv
biBpcyBub3QgeWV0DQphdmFpbGFibGUsIEkgd2lsbCBzdWJtaXQgYSByZXZlcnQgZm9yIHRoaXMg
cGF0Y2guDQoNCkJhcnQu
