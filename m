Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DAB3067B59
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 09:44:24 +1000 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k7HNiMdZ022178
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 19:44:22 -0400
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with ESMTP id
	k7HNiLCR221800
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:44:21 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k7HNiKho005529
	for <linuxppc-dev@ozlabs.org>; Thu, 17 Aug 2006 17:44:21 -0600
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 02/13] IB/ehca: includes
Date: Fri, 18 Aug 2006 01:44:17 +0200
References: <20068171311.X1v1Q4Gk1v3wd7qJ@cisco.com>
In-Reply-To: <20068171311.X1v1Q4Gk1v3wd7qJ@cisco.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608180144.19149.arnd.bergmann@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org, RAISCH@de.ibm.com,
	HNGUYEN@de.ibm.com, MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1cnNkYXkgMTcgQXVndXN0IDIwMDYgMjI6MTEsIFJvbGFuZCBEcmVpZXIgd3JvdGU6Cj4g
KyAqIElTX0VERUJfT04gLSBDaGVja3MgaWYgZGVidWcgaXMgb24gZm9yIHRoZSBnaXZlbiBsZXZl
bC4KPiArICovCj4gKyNkZWZpbmUgSVNfRURFQl9PTihsZXZlbCkgXAo+ICsoKGVoY2FfZWRlYl9m
aWx0ZXIobGV2ZWwsIEVERUJfSURfVE9fVTMyKERFQl9QUkVGSVgpLCBfX0xJTkVfXykgJiBcCj4g
KyCgMHgxMDAwMDAwMDBMKSA9PSAwKQo+ICsKPiArI2RlZmluZSBFREVCX1BfR0VORVJJQyhsZXZl
bCxpZHN0cmluZyxmb3JtYXQsYXJncy4uLikgXAo+ICtkbyB7IFwKPiAroKCgoKCgoHU2NCBlaGNh
X2VkZWJfZmlsdGVycmVzdWx0ID2goKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBc
Cj4gK6CgoKCgoKCgoKCgoKCgoGVoY2FfZWRlYl9maWx0ZXIobGV2ZWwsIEVERUJfSURfVE9fVTMy
KERFQl9QUkVGSVgpLCBfX0xJTkVfXyk7XAo+ICugoKCgoKCgaWYgKChlaGNhX2VkZWJfZmlsdGVy
cmVzdWx0ICYgMHgxMDAwMDAwMDBMKSA9PSAwKaCgoKCgoKCgoKCgoKCgoFwKPiAroKCgoKCgoKCg
oKCgoKCgcHJpbnRrKCJQVSUwNHggJTA4eDolcyAiIGlkc3RyaW5nICIgImZvcm1hdCAiXG4iLKCg
oKCgoKBcCj4gK6CgoKCgoKCgoKCgoKCgoCCgIKAgoCBnZXRfcGFjYSgpLT5wYWNhX2luZGV4LCAo
dTMyKShlaGNhX2VkZWJfZmlsdGVycmVzdWx0KSwgXAo+ICugoKCgoKCgoKCgoKCgoKAgoCCgIKAg
X19mdW5jX18sIKAjI2FyZ3MpO6CgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoFwKPiArfSB3
aGlsZSAoMSA9PSAwKQoKVGhlc2UgbWFjcm9zIGFyZSByZXNwb25zaWJsZSBmb3IgNjElIG9mIHRo
ZSBvYmplY3QgY29kZSBzaXplIG9mIHlvdXIgbW9kdWxlLgpUaGlzIGlzIGNvbXBsZXRlbHkgaW5z
YW5lLiBQbGVhc2UgZ2V0IHJpZCBvZiB0aGF0IGNyYXAgZW50aXJlbHkgYW5kIHJlcGxhY2UKaXQg
d2l0aCBkZXZfaW5mby9kZXZfZGJnL2Rldl93YXJuIGNhbGxzIHdoZXJlIGFwcHJvcHJpYXRlIQoK
CUFybmQgPD48Cg==
