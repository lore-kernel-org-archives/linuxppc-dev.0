Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 475A5DE038
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Aug 2008 21:30:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/4] kvmppc: add hypercall infrastructure - guest part
Date: Tue, 19 Aug 2008 13:28:16 +0200
References: <1219142204-12044-1-git-send-email-ehrhardt@linux.vnet.ibm.com>
	<1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
In-Reply-To: <1219142204-12044-3-git-send-email-ehrhardt@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200808191328.16934.arnd@arndb.de>
Cc: hollisb@us.ibm.com, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVHVlc2RheSAxOSBBdWd1c3QgMjAwOCwgZWhyaGFyZHRAbGludXgudm5ldC5pYm0uY29tIHdy
b3RlOgo+ICtzdGF0aWMgaW5saW5lIGxvbmcga3ZtX2h5cGVyY2FsbDEodW5zaWduZWQgaW50IG5y
LCB1bnNpZ25lZCBsb25nIHAxKQo+ICt7Cj4gK6CgoKCgoKByZWdpc3RlciB1bnNpZ25lZCBsb25n
IGhjYWxsIGFzbSAoInIwIikgPSBucjsKPiAroKCgoKCgoHJlZ2lzdGVyIHVuc2lnbmVkIGxvbmcg
YXJnMSBhc20gKCJyMyIpID0gcDE7Cj4gK6CgoKCgoKByZWdpc3RlciBsb25nIHJldCBhc20gKCJy
MTEiKTsKPiArCj4gK6CgoKCgoKBhc20gdm9sYXRpbGUoIi5sb25nICUxIgo+ICugoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoDogIj1yIihyZXQpCj4gK6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgOiAiaSIo
S1ZNX0hZUEVSQ0FMTF9CSU4pLCAiciIoaGNhbGwpLCAiciIoYXJnMSkKPiAroKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKA6ICJyNCIsICJyNSIsICJyNiIsICJyNyIsICJyOCIsCj4gK6CgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgIKAicjkiLCAicjEwIiwgInIxMiIsICJjYyIpOwo+ICugoKCgoKCgcmV0dXJu
IHJldDsKPiArfQoKV2hhdCBpcyB0aGUgcmVhc29uaW5nIGZvciBtYWtpbmcgdGhlIGNhbGxpbmcg
Y29udmVudGlvbiBkaWZmZXJlbnQgZnJvbQphbGwgdGhlIGV4aXN0aW5nIGhjYWxsIGludGVyZmFj
ZXMgaGVyZT8KCnBzZXJpZXMgdXNlcyByMyBmb3IgdGhlIGhjYWxsIG51bWJlciwgbHYxIGFuZCBi
ZWF0IHVzZSByMTEsIHNvIHVzaW5nCnIwIGp1c3QgZm9yIHRoZSBzYWtlIG9mIGJlaW5nIGRpZmZl
cmVudCBzZWVtcyBjb3VudGVyaW50dWl0aXZlLgoKCUFybmQgPD48Cg==
