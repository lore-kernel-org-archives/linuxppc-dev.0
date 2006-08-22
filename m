Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97F5F67C71
	for <linuxppc-dev@ozlabs.org>; Wed, 23 Aug 2006 00:01:31 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7ME1SnJ029163
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:01:28 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7ME1QgP279172
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:01:26 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7ME1Pat031427
	for <linuxppc-dev@ozlabs.org>; Tue, 22 Aug 2006 10:01:25 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
Date: Tue, 22 Aug 2006 16:01:24 +0200
References: <200608221453.49667.ossthema@de.ibm.com>
In-Reply-To: <200608221453.49667.ossthema@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608221601.24882.arnd.bergmann@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVHVlc2RheSAyMiBBdWd1c3QgMjAwNiAxNDo1MywgSmFuLUJlcm5kIFRoZW1hbm4gd3JvdGU6
Cj4gK6CgoKCgoKB1NjQgcnBhZ2UgPSAwOwo+ICugoKCgoKCgaW50IHJldDsKPiAroKCgoKCgoGlu
dCBjbnQgPSAwOwo+ICugoKCgoKCgdm9pZCAqdnBhZ2UgPSBOVUxMOwo+ICsKPiAroKCgoKCgoHJl
dCA9IGh3X3F1ZXVlX2N0b3IoaHdfcXVldWUsIG5yX3BhZ2VzLCBFSEVBX1BBR0VTSVpFLCB3cWVf
c2l6ZSk7Cj4gK6CgoKCgoKBpZiAocmV0KQo+ICugoKCgoKCgoKCgoKCgoKByZXR1cm4gcmV0Owo+
ICsKPiAroKCgoKCgoGZvciAoY250ID0gMDsgY250IDwgbnJfcGFnZXM7IGNudCsrKSB7Cj4gK6Cg
oKCgoKCgoKCgoKCgoHZwYWdlID0gaHdfcXBhZ2VpdF9nZXRfaW5jKGh3X3F1ZXVlKTsKPiAroKCg
oKCgoKCgoKCgoKCgaWYgKCF2cGFnZSkgewo+ICugoKCgoKCgoKCgoKCgoKCgoKCgoKCgoGVoZWFf
ZXJyb3IoImh3X3FwYWdlaXRfZ2V0X2luYyBmYWlsZWQiKTsKPiAroKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKBnb3RvIHFwX2FsbG9jX3JlZ2lzdGVyX2V4aXQwOwo+ICugoKCgoKCgoKCgoKCgoKB9Cj4g
K6CgoKCgoKCgoKCgoKCgoHJwYWdlID0gdmlydF90b19hYnModnBhZ2UpOwoKQXMgc29tZW9uZSBt
ZW50aW9uZWQgYmVmb3JlLCB0aGUgaW5pdGlhbGl6YXRpb24gdG8gMCBvciBOVUxMCmlzIHBvaW50
bGVzcyBoZXJlLCBhcyB0aGUgdmFyaWFibGVzIGFyZSBhbHdheXMgYXNzaWduZWQgYmVmb3JlCnRo
ZXkgYXJlIHVzZWQuIFRoZXJlIGFyZSBhIG51bWJlciBvZiBvdGhlciBwbGFjZXMgaW4geW91cgpj
b2RlIHRoYXQgZG8gc2ltaWxhciB0aGluZ3MsIHlvdSBzaG91bGQgcHJvYmFibHkgZ28gdGhyb3Vn
aAp0aGVzZSBhbmQgcmVtb3ZlIHRoZSBpbml0aWFsaXplcnMuCgpJZiB5b3UgaW5kZWVkIG5lZWQg
c29tZXRoaW5nIHRvIGJlIGluaXRpYWxpemVkLCBpdCBpcyBnb29kIHByYWN0aWNlCnRvIGRvIHRo
ZSBpbml0aWFsaXphdGlvbiBhcyBsYXRlIGFzIHBvc3NpYmxlLCBlLmcuCgoJaW50IGZvbzsKCS4u
LgoJZm9vID0gMDsKCWRvX2Zvbyhmb28pOwoKdG8gbWFrZSBpdCBjbGVhciB0aGF0IHlvdSBoYXZl
IGEgcmVhc29uIHRvIGluaXRpYWxpemUgaXQuCgoJQXJuZCA8PjwK
