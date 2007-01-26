Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D50FEDE03D
	for <linuxppc-dev@ozlabs.org>; Fri, 26 Jan 2007 15:28:34 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 6/14] ps3: smp interrupt fixes
Date: Fri, 26 Jan 2007 05:28:26 +0100
References: <45B81883.2010508@am.sony.com> <200701250707.07626.arnd@arndb.de>
	<45B96BC5.3090308@am.sony.com>
In-Reply-To: <45B96BC5.3090308@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200701260528.27438.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gRnJpZGF5IDI2IEphbnVhcnkgMjAwNyAwMzo0NywgR2VvZmYgTGV2YW5kIHdyb3RlOgo+IFNv
cnJ5LCBJIGRvbid0IHF1aXRlIHVuZGVyc3RhbmQgd2hhdCB5b3UgbWVhbiBieSAndXNpbmcgYSBj
b25zdGFudCBkZWZpbml0aW9uCj4gZm9yIGl0Jy4gwqBDb3VsZCB5b3UgZWxhYm9yYXRlPwoKSSBh
c3N1bWVkIHRoYXQgJzY0JyBoYWQgYSBzcGVjaWFsIG1lYW5pbmcgaW4gdGhpcywgd2hpY2ggd291
bGQgYmUgaWRlYWxseQpleHByZXNzZWQgYnkgc29tZXRoaW5nIGxpa2UKCiNkZWZpbmUgUFMzX0JJ
VE1BUF9NSU5BTElHTiA2NAoKd2hpY2ggaXQgb25seSBoYXMgaW5kaXJlY3RseSwgaW5zdGVhZAoK
PiBBcyB5b3Ugc3VnZ2VzdGVkIEkgaGF2ZSBhbHJlYWR5IGNoYW5nZWQgdGhpcyB0bzoKPiAKPiBz
dHJ1Y3QgcHMzX2JtcCB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCB7Cj4gwqDCoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqB1NjQgc3RhdHVzOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgdTY0IHVudXNlZF8xWzNdOwo+IMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgdTY0IG1hc2s7Cj4gwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqB1NjQgdW51c2Vk
XzJbM107Cj4gwqDCoMKgwqDCoMKgwqDCoH07Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBpcGlfZGVi
dWdfYnJrX21hc2s7Cj4gwqDCoMKgwqDCoMKgwqDCoHNwaW5sb2NrX3QgbG9jazsKPiB9Owo+IAo+
IHN0cnVjdCBwczNfcHJpdmF0ZSB7Cj4gwqDCoMKgwqDCoMKgwqDCoHN0cnVjdCBwczNfYm1wIGJt
cCBfX2F0dHJpYnV0ZV9fICgoYWxpZ25lZCAoNjQpKSk7Cj4gwqDCoMKgwqDCoMKgwqDCoHU2NCBu
b2RlOwo+IMKgwqDCoMKgwqDCoMKgwqB1bnNpZ25lZCBpbnQgY3B1Owo+IH07CgppdCB3b3VsZCBi
ZSBldmVuIGJldHRlciB0byBhZGQgYSBjb21tZW50IHRvIHRoaXMgc3RydWN0IGxpa2UKCi8qIGFs
aWduZWQoNjQpIGJlY2F1c2UgcHMzX2JtcCBtdXN0IG5vdCBjcm9zcyBwYWdlIGJvdW5kYXJpZXMg
Ki8KCglBcm5kIDw+PAo=
