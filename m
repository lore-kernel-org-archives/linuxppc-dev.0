Return-Path: <R61911@freescale.com>
Received: from VA3EHSOBE009.bigfish.com (va3ehsobe006.messaging.microsoft.com
	[216.32.180.16]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "mail.global.frontbridge.com",
	Issuer "Cybertrust SureServer Standard Validation CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3140CB70F6
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 17:43:28 +1100 (EST)
Received: from mail87-va3 (localhost.localdomain [127.0.0.1])	by
	mail87-va3-R.bigfish.com (Postfix) with ESMTP id 992469B8292	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 06:43:24 +0000 (UTC)
Received: from VA3EHSMHS013.bigfish.com (unknown [10.7.14.236])	by
	mail87-va3.bigfish.com (Postfix) with ESMTP id 3E79D1E004C	for
	<linuxppc-dev@ozlabs.org>; Thu, 14 Oct 2010 06:43:24 +0000 (UTC)
Received: from de01smr02.am.mot.com (de01smr02.freescale.net [10.208.0.151])
	by az33egw02.freescale.net (8.14.3/8.14.3) with ESMTP id
	o9E6hMm4021446	for
	<linuxppc-dev@ozlabs.org>; Wed, 13 Oct 2010 23:43:22 -0700 (MST)
Received: from zch01exm23.fsl.freescale.net (zch01exm23.ap.freescale.net
	[10.192.129.207])	by de01smr02.am.mot.com (8.13.1/8.13.0) with ESMTP id
	o9E6xaDp001673	for <linuxppc-dev@ozlabs.org>;
	Thu, 14 Oct 2010 01:59:37 -0500 (CDT)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Subject: RE: [PATCH 1/3 v4] P4080/eLBC: Make Freescale elbc interrupt common
	to elbc devices
Date: Thu, 14 Oct 2010 14:43:38 +0800
Message-ID: <3850A844E6A3854C827AC5C0BEC7B60A2B0329@zch01exm23.fsl.freescale.net>
In-Reply-To: <20100920153718.GA4411@oksana.dev.rtsoft.ru>
References: <1284706869-12555-1-git-send-email-tie-fei.zang@freescale.com>
	<20100920153718.GA4411@oksana.dev.rtsoft.ru>
From: Zang Roy-R61911 <r61911@freescale.com>
To: Anton Vorontsov <cbouatmailru@gmail.com>
Cc: Wood Scott-B07421 <B07421@freescale.com>, dedekind1@gmail.com,
	Lan Chunhe-B25806 <B25806@freescale.com>,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	akpm@linux-foundation.org, dwmw2@infradead.org,
	Gala Kumar-B11780 <B11780@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW50b24gVm9yb250c292
IFttYWlsdG86Y2JvdWF0bWFpbHJ1QGdtYWlsLmNvbV0NCj4gU2VudDogTW9uZGF5LCBTZXB0ZW1i
ZXIgMjAsIDIwMTAgMjM6MzcgUE0NCj4gVG86IFphbmcgUm95LVI2MTkxMQ0KPiBDYzogbGludXgt
bXRkQGxpc3RzLmluZnJhZGVhZC5vcmc7IGR3bXcyQGluZnJhZGVhZC5vcmc7IGRlZGVraW5kMUBn
bWFpbC5jb207DQo+IGFrcG1AbGludXgtZm91bmRhdGlvbi5vcmc7IExhbiBDaHVuaGUtQjI1ODA2
OyBXb29kIFNjb3R0LUIwNzQyMTsgR2FsYSBLdW1hci0NCj4gQjExNzgwOyBsaW51eHBwYy1kZXZA
b3psYWJzLm9yZw0KPiBTdWJqZWN0OiBSZTogW1BBVENIIDEvMyB2NF0gUDQwODAvZUxCQzogTWFr
ZSBGcmVlc2NhbGUgZWxiYyBpbnRlcnJ1cHQgY29tbW9uDQo+IHRvIGVsYmMgZGV2aWNlcw0KPiAN
Cj4gT24gRnJpLCBTZXAgMTcsIDIwMTAgYXQgMDM6MDE6MDdQTSArMDgwMCwgUm95IFphbmcgd3Jv
dGU6DQoNCltzbmlwXQ0KDQo+ID4gIGludCBmc2xfdXBtX3J1bl9wYXR0ZXJuKHN0cnVjdCBmc2xf
dXBtICp1cG0sIHZvaWQgX19pb21lbSAqaW9fYmFzZSwgdTMyIG1hcikNCj4gPiAgew0KPiA+ICAJ
aW50IHJldCA9IDA7DQo+ID4gIAl1bnNpZ25lZCBsb25nIGZsYWdzOw0KPiBbLi4uXQ0KPiA+ICtz
dGF0aWMgaW50IF9fZGV2aW5pdCBmc2xfbGJjX2N0cmxfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqZGV2KQ0KPiA+ICt7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsNCj4gPiArCWlmICghZGV2
LT5kZXYub2Zfbm9kZSkgew0KPiA+ICsJCWRldl9lcnIoJmRldi0+ZGV2LCAiRGV2aWNlIE9GLU5v
ZGUgaXMgTlVMTCIpOw0KPiA+ICsJCXJldHVybiAtRUZBVUxUOw0KPiA+ICsJfQ0KPiA+ICsJZnNs
X2xiY19jdHJsX2RldiA9IGt6YWxsb2Moc2l6ZW9mKCpmc2xfbGJjX2N0cmxfZGV2KSwgR0ZQX0tF
Uk5FTCk7DQo+IA0KPiBCdHcsIHRoZSBjb2RlIGluIHRoZSBOQU5EIGRyaXZlciBjaGVja3MgZm9y
ICFmc2xfbGJjX2N0cmxfZGV2Lg0KPiANCj4gU28gaXQgbWlnaHQgbWFrZSBzZW5zZSB0byBhc3Np
Z24gdGhlIGdsb2JhbCB2YXJpYWJsZSBhZnRlciB0aGUNCj4gc3RydWN0IGlzIGZ1bGx5IGluaXRp
YWxpemVkLg0KV2hhdCBzdHJ1Y3Q/DQphc3NpZ24gdGhlIGdsb2JhbCB2YXJpYWJsZSBpbiBuYW5k
IGRyaXZlcj8gDQpJJ2QgcHJlZmVyIGluaXQgaXQgaW4gdGhlIGxiYyBjb2RlLg0KVGhlcmUgbWF5
IGJlIG90aGVyIGxiYyBkZXZpY2UsIHdobyB3aWxsIHVzZSB0aGlzICBnbG9iYWwgdmFyaWFibGUu
DQoNCj4gDQo+ID4gKwlpZiAoIWZzbF9sYmNfY3RybF9kZXYpDQo+ID4gKwkJcmV0dXJuIC1FTk9N
RU07DQo+ID4gKw0KPiA+ICsJZGV2X3NldF9kcnZkYXRhKCZkZXYtPmRldiwgZnNsX2xiY19jdHJs
X2Rldik7DQo+ID4gKw0KPiA+ICsJc3Bpbl9sb2NrX2luaXQoJmZzbF9sYmNfY3RybF9kZXYtPmxv
Y2spOw0KPiA+ICsJaW5pdF93YWl0cXVldWVfaGVhZCgmZnNsX2xiY19jdHJsX2Rldi0+aXJxX3dh
aXQpOw0KPiA+ICsNCj4gPiArCWZzbF9sYmNfY3RybF9kZXYtPnJlZ3MgPSBvZl9pb21hcChkZXYt
PmRldi5vZl9ub2RlLCAwKTsNCj4gPiArCWlmICghZnNsX2xiY19jdHJsX2Rldi0+cmVncykgew0K
PiA+ICsJCWRldl9lcnIoJmRldi0+ZGV2LCAiZmFpbGVkIHRvIGdldCBtZW1vcnkgcmVnaW9uXG4i
KTsNCj4gPiArCQlyZXQgPSAtRU5PREVWOw0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+ICsJfQ0KPiA+
ICsNCj4gPiArCWZzbF9sYmNfY3RybF9kZXYtPmlycSA9IGlycV9vZl9wYXJzZV9hbmRfbWFwKGRl
di0+ZGV2Lm9mX25vZGUsIDApOw0KPiA+ICsJaWYgKGZzbF9sYmNfY3RybF9kZXYtPmlycSA9PSBO
T19JUlEpIHsNCj4gPiArCQlkZXZfZXJyKCZkZXYtPmRldiwgImZhaWxlZCB0byBnZXQgaXJxIHJl
c291cmNlXG4iKTsNCj4gPiArCQlyZXQgPSAtRU5PREVWOw0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+
ICsJfQ0KPiA+ICsNCj4gPiArCWZzbF9sYmNfY3RybF9kZXYtPmRldiA9ICZkZXYtPmRldjsNCj4g
PiArDQo+ID4gKwlyZXQgPSBmc2xfbGJjX2N0cmxfaW5pdChmc2xfbGJjX2N0cmxfZGV2KTsNCj4g
PiArCWlmIChyZXQgPCAwKQ0KPiA+ICsJCWdvdG8gZXJyOw0KPiA+ICsNCj4gPiArCXJldCA9IHJl
cXVlc3RfaXJxKGZzbF9sYmNfY3RybF9kZXYtPmlycSwgZnNsX2xiY19jdHJsX2lycSwgMCwNCj4g
PiArCQkJCSJmc2wtbGJjIiwgZnNsX2xiY19jdHJsX2Rldik7DQo+ID4gKwlpZiAocmV0ICE9IDAp
IHsNCj4gPiArCQlkZXZfZXJyKCZkZXYtPmRldiwgImZhaWxlZCB0byBpbnN0YWxsIGlycSAoJWQp
XG4iLA0KPiA+ICsJCQlmc2xfbGJjX2N0cmxfZGV2LT5pcnEpOw0KPiA+ICsJCXJldCA9IGZzbF9s
YmNfY3RybF9kZXYtPmlycTsNCj4gPiArCQlnb3RvIGVycjsNCj4gPiArCX0NCj4gPiArDQo+ID4g
KwlyZXR1cm4gMDsNCj4gPiArDQo+ID4gK2VycjoNCj4gPiArCWlvdW5tYXAoZnNsX2xiY19jdHJs
X2Rldi0+cmVncyk7DQo+ID4gKwlrZnJlZShmc2xfbGJjX2N0cmxfZGV2KTsNCj4gPiArCXJldHVy
biByZXQ7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNl
X2lkIGZzbF9sYmNfbWF0Y2hbXSA9IHsNCj4gDQo+ICNpbmNsdWRlIDxsaW51eC9tb2RfZGV2aWNl
dGFibGUuaD4gaXMgbmVlZGVkIGZvciB0aGlzLg0KPiANCj4gDQo+IFBsdXMsIEkgdGhpbmsgdGhl
IHBhdGNoIGlzIG5vdCBydW50aW1lIGJpc2VjdGFibGUgKGkuZS4geW91DQo+IG5vdyBkbyByZXF1
ZXN0X2lycSgpIGhlcmUsIGJ1dCBub3QgcmVtb3ZpbmcgaXQgZnJvbSB0aGUgbmFuZA0KPiBkcml2
ZXIsIHNvIG5hbmQgd2lsbCBmYWlsIHRvIHByb2JlKS4NCk5hbmQgZHJpdmVyIGRvZXMgbm90IG5l
ZWQgdG8gcmVxdWVzdCBpcnEuIEl0IHdpbGwgdXNlIHRoZSBpcnEgcmVxdWVzdGVkIGJ5IGxiYy4N
CnJlbWVtYmVyLCBvdGhlciBsYmMgZGV2aWNlIG1heSBhbHNvIG5lZWQgdG8gdXNlIHRoaXMgcmVn
aXN0ZXJlZCBpcnEuIA0KSXQgc2hvdWxkIG5vdCBiZSByZW1vdmVkIGluIG5hbmQgZHJpdmVyLg0K
DQpUaGFua3MuDQpSb3kNCg==
