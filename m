Return-Path: <David.Laight@ACULAB.COM>
Received: from smtp-out4.electric.net (smtp-out4.electric.net
 [192.162.216.185])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xtCr50yWkzDqr8
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 Sep 2017 19:28:03 +1000 (AEST)
From: David Laight <David.Laight@ACULAB.COM>
To: 'Benjamin Herrenschmidt' <benh@kernel.crashing.org>, Alexey Kardashevskiy
 <aik@ozlabs.ru>
CC: Alistair Popple <alistair@popple.id.au>, Bjorn Helgaas
 <helgaas@kernel.org>, "shan.gavin@gmail.com" <shan.gavin@gmail.com>, "Paul
 Mackerras" <paulus@samba.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, David Gibson <david@gibson.dropbear.id.au>
Subject: RE: [PATCH kernel] powerpc/powernv: Update comment about shifting
 IOV BAR
Date: Thu, 14 Sep 2017 09:27:52 +0000
Message-ID: <063D6719AE5E284EB5DD2968C1650D6DD0076B19@AcuExch.aculab.com>
References: <20170831033412.1971-1-aik@ozlabs.ru>
 <0d7068aa-7331-0ce0-145d-8afe1e83a8ec@ozlabs.ru>
 <1505358454.12628.185.camel@kernel.crashing.org>
 <18f3462e-09ee-ce02-f9c6-eafad68cb9c6@ozlabs.ru>
 <1505360385.12628.187.camel@kernel.crashing.org>
In-Reply-To: <1505360385.12628.187.camel@kernel.crashing.org>
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

RnJvbTogQmVuamFtaW4gSGVycmVuc2NobWlkdA0KPiBTZW50OiAxNCBTZXB0ZW1iZXIgMjAxNyAw
NDo0MA0KPiBPbiBUaHUsIDIwMTctMDktMTQgYXQgMTM6MTggKzEwMDAsIEFsZXhleSBLYXJkYXNo
ZXZza2l5IHdyb3RlOg0KPiA+IE9uIDE0LzA5LzE3IDEzOjA3LCBCZW5qYW1pbiBIZXJyZW5zY2ht
aWR0IHdyb3RlOg0KPiA+ID4gT24gVGh1LCAyMDE3LTA5LTE0IGF0IDEyOjQ1ICsxMDAwLCBBbGV4
ZXkgS2FyZGFzaGV2c2tpeSB3cm90ZToNCj4gPiA+ID4gT24gMzEvMDgvMTcgMTM6MzQsIEFsZXhl
eSBLYXJkYXNoZXZza2l5IHdyb3RlOg0KPiA+ID4gPiA+IEZyb206IEJlbmphbWluIEhlcnJlbnNj
aG1pZHQgPGJlbmhAa2VybmVsLmNyYXNoaW5nLm9yZz4NCj4gPiA+ID4NCj4gPiA+ID4gT29wcywg
dGhpcyB3YXMgbm90IHJpZ2h0IDopDQo+ID4gPiA+DQo+ID4gPiA+IEFueXdheSwgQmVuLCBwbGVh
c2UgY29tbWVudC4gVGhhbmtzLg0KPiA+ID4NCj4gPiA+IFRoaXMgaXMgaW5jb3JyZWN0LCB3ZSBj
YW4gZG8gaG90cGx1ZyBiZWhpbmQgc3dpdGNoZXMgYWZhaWsuDQo+ID4NCj4gPiBEbyB3ZSBoYXZl
IGFuIGFjdHVhbCBzeXN0ZW0gd2hpY2ggYWxsb3dzIHRoaXM/DQo+IA0KPiBUdWxldGEgbm8gPw0K
DQpZb3UgY2FuIGxvZ2ljYWxseSAnaG90cGx1ZycgUENJKGUpIG9uIGFueSBzeXN0ZW0gWzFdLg0K
DQpUaGUgJ3Byb2JsZW0nIGlzIHRoYXQgd2hhdGV2ZXIgZW51bWVyYXRlcyB0aGUgUENJKGUpIGF0
IHN5c3RlbQ0KcG93ZXJ1cCBkb2Vzbid0IG5vcm1hbGx5IGFzc2lnbiBleHRyYSByZXNvdXJjZXMg
dG8gYnJpZGdlcyB0byBhbGxvdw0KZm9yIGRldmljZXMgdGhhdCBhcmVuJ3QgcHJlc2VudCBhdCBi
b290IHRpbWUuDQpTbyB5b3UgY2FuIG5vcm1hbGx5IG9ubHkgcmVwbGFjZSBjYXJkcyB3aXRoIG9u
ZXMgdGhhdCB1c2UgdGhlIHNhbWUNCihvciBsZXNzKSByZXNvdXJjZXMsIG9yIHRoYXQgYXJlIG5v
dCBiZWhpbmQgYW55IGJyaWRnZXMuDQpUaGlzIGlzIHByb2JsZW1hdGljIGlmIHlvdSBoYXZlIGEg
ZG9ja2luZyBzdGF0aW9uIGNvbm5lY3RlZCB2aWENCmEgYnJpZGdlLg0KDQpbMV0gQXBhcnQgZnJv
bSBzb21lIGFubm95aW5nIHg4NiBEZWxsIHNlcnZlcnMgd2UgaGF2ZSB3aGljaCBnZW5lcmF0ZQ0K
YW4gTk1JIHdoZW4gdGhlIFBDSWUgbGluayBnb2VzIGRvd24gKHdoZW4gd2UgcmVwcm9ncmFtIHRo
ZSBmcGdhKS4NClRoZXkgYWxzbyBmYWlsIHRvIGJvb3QgaWYgYSBsaW5rIGRvZXNuJ3QgY29tZSB1
cC4uLg0KDQoJRGF2aWQNCg0K
