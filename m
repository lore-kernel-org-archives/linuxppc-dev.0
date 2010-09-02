Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from echo.usurf.usu.edu (unknown [129.123.194.129])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "echo", Issuer "echo" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 8A102B719E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri,  3 Sep 2010 01:54:55 +1000 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: RE: Memory allocation modifications in ibm_newemac driver AND sil24
	driver
Date: Thu, 2 Sep 2010 15:54:50 +0000
Message-ID: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC12822018@Mercury.usurf.usu.edu>
References: <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2F09@Mercury.usurf.usu.edu>
	, <5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A2FBE@Mercury.usurf.usu.edu>	 ,
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A301B@Mercury.usurf.usu.edu>
	<5ABE8A5E96C0364CAF2B4DC1DEB7CEAC127A305B@Mercury.usurf.usu.edu>
	<1283401130.16240.9.camel@pasglop>
In-Reply-To: <1283401130.16240.9.camel@pasglop>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Cc: "linux-net@vger.kernel.org" <linux-net@vger.kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Pj4gQ2FuIGFueW9uZSBleHBsYWluIHRvIG1lIHdoeSBJIHdvdWxkIGJlIGdldHRpbmcgdGhpcyBl
cnJvciBpbiB0aGUNCj4+IGZpcnN0IHBsYWNlPyAgV2h5IGlzIGl0IGZhaWxpbmcgdG8gYWxsb2Nh
dGUgYSBwYWdlIHdoZW4gdGhlcmUgYXJlDQo+PiBwYWdlcyBhdmFpbGFibGU/ICBUaGF0IGRvZXMg
bm90IG1ha2UgYW55IHNlbnNlIHRvIG1lLg0KDQo+IG9yZGVyOjENCg0KPiBJdCdzIGZhaWxpbmcg
dG8gYWxsb2NhdGUgLXR3by0gcGFnZXMuDQoNCkdvb2QgcG9pbnQuICBIb3dldmVyLCB3aHkgaXMg
aXQgZmFpbGluZz8gIEFjY29yZGluZyB0byB0aGUgZHVtcCwgdGhlcmUgYXJlIDI4IDhrIHBhZ2Vz
IGF2YWlsYWJsZS4NCg0KRnJvbSBkb2luZyBtb3JlIHRlc3RpbmcgeWVzdGVyZGF5LCBJIGZvdW5k
IHRoYXQgdGhpcyBlcnJvciBpcyBhbHNvIGNvbWluZyB1cCBmcm9tIHRoZSBTQVRBIGRyaXZlciBh
cyB3ZWxsIChzaWwyNCkuICBBZ2FpbiB3aXRoIHRob3NlIGVycm9ycywgaXQgZmFpbHMgYWxsb2Nh
dGluZyBhIHBhZ2Ugb2Ygb3JkZXIgMCwgd2hlbiB0aGVyZSBhcmUgYSBmZXcgaHVuZHJlZCBvZiB0
aG9zZSBhdmFpbGFibGUuICBXaGF0IGlzIHVwIHdpdGggdGhlIFZNTT8gIFdoeSBhcmUgcGFnZXMg
ZmFpbGluZyB0byBhbGxvY2F0ZSB3aGVuIHRoZXkgYXJlIGF2YWlsYWJsZT8NCg0KVGhhbmtzLA0K
DQpKb25hdGhhbg0KDQoNCg==
