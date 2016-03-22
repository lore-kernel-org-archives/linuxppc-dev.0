Return-Path: <Nora.Bjorklund@enea.com>
Received: from mx-3.enea.com (sestofw01.enea.se [192.36.1.252])
 by lists.ozlabs.org (Postfix) with SMTP id 3qTnQr6jFhzDq6X
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Mar 2016 20:27:11 +1100 (AEDT)
From: =?utf-8?B?Tm9yYSBCasO2cmtsdW5k?= <Nora.Bjorklund@enea.com>
To: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "oss@buserror.net" <oss@buserror.net>, "benh@kernel.crashing.org"
 <benh@kernel.crashing.org>
Subject: Re: [PATCH] powerpc:dts:p2041rdb: enable gpio-expander
Date: Tue, 22 Mar 2016 09:26:43 +0000
Message-ID: <1458638754.1197.7.camel@enea.com>
References: <1458557331-59540-1-git-send-email-nora.bjorklund@enea.com>
 <1458583080.19333.11.camel@buserror.net>
In-Reply-To: <1458583080.19333.11.camel@buserror.net>
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

T24gTW9uLCAyMDE2LTAzLTIxIGF0IDEyOjU4IC0wNTAwLCBTY290dCBXb29kIHdyb3RlOg0KPiBP
biBNb24sIDIwMTYtMDMtMjEgYXQgMTE6NDggKzAxMDAsIE5vcmEgQmrDtnJrbHVuZCB3cm90ZToN
Cj4gPiANCj4gPiBFbmFibGUgdGhlIGdwaW8tZXhwYW5kZXIgcGNhOTY3MiBvbiBwMjA0MXJkYi4g
VGhlIGV4cGFuZGVyDQo+ID4gaGFzIGJlZW4gcHJlc2VudCBvbiB0aGUgcDIwNDFyZGIgYWxsIGFs
b25nLCBob3dldmVyIG5vdCBpbg0KPiA+IHRoZSBkZXZpY2UgdHJlZS4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBOb3JhIEJqw7Zya2x1bmQgPG5vcmEuYmpvcmtsdW5kQGVuZWEuY29tPg0KPiA+
IC0tLQ0KPiA+IMKgYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL2ZzbC9wMjA0MXJkYi5kdHMgfCA3ICsr
KysrKysNCj4gPiDCoDEgZmlsZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBk
aWZmIC0tZ2l0IGEvYXJjaC9wb3dlcnBjL2Jvb3QvZHRzL2ZzbC9wMjA0MXJkYi5kdHMNCj4gPiBi
L2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvcDIwNDFyZGIuZHRzDQo+ID4gaW5kZXggZTliZDg5
NC4uYjFlZTU2MSAxMDA2NDQNCj4gPiAtLS0gYS9hcmNoL3Bvd2VycGMvYm9vdC9kdHMvZnNsL3Ay
MDQxcmRiLmR0cw0KPiA+ICsrKyBiL2FyY2gvcG93ZXJwYy9ib290L2R0cy9mc2wvcDIwNDFyZGIu
ZHRzDQo+ID4gQEAgLTEzNCw2ICsxMzQsMTMgQEANCj4gPiDCoAkJCX07DQo+ID4gwqAJCX07DQo+
ID4gwqANCj4gPiArCQlpMmNAMTE5MTAwIHsNCj4gPiArCQkJZ3Bpb0AyMiB7DQo+ID4gKwkJCQlj
b21wYXRpYmxlID0gInBjZjg1NzUiOw0KPiA+ICsJCQkJcmVnID0gPDB4MjI+Ow0KPiA+ICsJCQl9
Ow0KPiA+ICsJCX07DQo+IFRoZSBjb21wYXRpYmxlIHNob3VsZCBiZSAibnhwLHBjZjg1NzUiIGFu
ZCBpdCBuZWVkcyB0aGUgZ3Bpby0NCj4gY29udHJvbGxlciBhbmQNCj4gI2dwaW8tY2VsbHMgcHJv
cGVydGllcy4NClNvcnJ5LCB0aGUgY29tcGF0aWJsZSBzaG91bGQgYWN0dWFsbHkgYmUgIm54cCxw
Y2E5NjcyIi4uDQo+IA0KPiBJcyB0aGVyZSBhbiBpbnRlcnJ1cHQgbGluZSBjb25uZWN0ZWQgdG8g
aXQ/DQpQQ0E5NjcyIGhhcyBhbiBpbnRlcnJ1cHQgbGluZSwgYW5kIGl0IHNob3VsZCBiZSBjb25u
ZWN0ZWQgdG8gaXJxcGluMCBpZg0KdGhlIG5hbWVnaXZpbmcgaW4gdGhlIHAyMDQxcmRiIFVHIGlz
IGZvbGxvd2luZyB0aGUgc2FtZSBwYXR0ZXJuIGFzIHRoZQ0Ka2VybmVsLg0KDQpXaWxsIHRyeSB0
byB0ZXN0IGFuZCB1cGRhdGUgZHVyaW5nIHRoZSB3ZWVrLg0KDQovTm9yYQ0KPiA6cQ0KDQo+IFNl
ZSBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvZ3Bpby9ncGlvLXBjZjg1N3gudHh0
DQo+IA0KPiAtU2NvdHQNCj4gDQo+IF9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fDQo+IExpbnV4cHBjLWRldiBtYWlsaW5nIGxpc3QNCj4gTGludXhwcGMtZGV2
QGxpc3RzLm96bGFicy5vcmcNCj4gaHR0cHM6Ly9saXN0cy5vemxhYnMub3JnL2xpc3RpbmZvL2xp
bnV4cHBjLWRldg==
