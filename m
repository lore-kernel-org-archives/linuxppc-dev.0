To: linuxppc-embedded@lists.linuxppc.org
Message-ID: <OF7C17DE34.03C86815-ONC1256BC3.004744BF@de.ibm.com>
From: "Stefan Koch4" <STK@de.ibm.com>
Date: Fri, 24 May 2002 16:22:06 +0200
Subject: memory problem with interrupt registration/freeing
MIME-Version: 1.0
Content-type: multipart/mixed;
	Boundary="0__=4EBBE150DFDD6B798f9e8a93df938690918c4EBBE150DFDD6B79"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


--0__=4EBBE150DFDD6B798f9e8a93df938690918c4EBBE150DFDD6B79
Content-type: text/plain; charset=us-ascii


sorry for the last email formatting...

--------------------------------------------------------

Does anybody know why the memory decreases if you do request_irq and then
free_irq ? Is this a bug
or wrong usage?

I made a little test module which loops over those two calls (see attachm.)
and after some iterations
the kernel (2.4.19-pre4, Walnut-board) began to kill processes and crashed
later.
Any ideas?

Thanks,

Stefan Koch

(See attached file: inttest.c)
--0__=4EBBE150DFDD6B798f9e8a93df938690918c4EBBE150DFDD6B79
Content-type: application/octet-stream;
	name="inttest.c"
Content-Disposition: attachment; filename="inttest.c"
Content-transfer-encoding: base64

Ci8qIGp1c3QgY29weSBwYXN0ZWQgdGhlIGhlYWRlcnMgZnJvbSBhbm90aGVyIGRyaXZlciAtIG5v
dCBhbGwgaXMgbmVlZGVkIDstKSAqLwoKI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPgojaW5jbHVk
ZSA8bGludXgva2VybmVsLmg+CiNpbmNsdWRlIDxsaW51eC92ZXJzaW9uLmg+CiNpbmNsdWRlIDxs
aW51eC9zY2hlZC5oPgojaW5jbHVkZSA8bGludXgvc3RyaW5nLmg+CiNpbmNsdWRlIDxsaW51eC90
aW1lci5oPgojaW5jbHVkZSA8bGludXgvcHRyYWNlLmg+CiNpbmNsdWRlIDxsaW51eC9lcnJuby5o
PgojaW5jbHVkZSA8bGludXgvaW9wb3J0Lmg+CiNpbmNsdWRlIDxsaW51eC9zbGFiLmg+CiNpbmNs
dWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KI2luY2x1ZGUgPGxpbnV4L3ZlcnNpb24uaD4KI2luY2x1
ZGUgPGxpbnV4L3BjaS5oPgojaW5jbHVkZSA8bGludXgvZGVsYXkuaD4KI2luY2x1ZGUgPGxpbnV4
L2luaXQuaD4KI2luY2x1ZGUgPGxpbnV4L25ldGRldmljZS5oPgojaW5jbHVkZSA8bGludXgvZXRo
ZXJkZXZpY2UuaD4KI2luY2x1ZGUgPGxpbnV4L3NrYnVmZi5oPgojaW5jbHVkZSA8bGludXgvcHJv
Y19mcy5oPgojaW5jbHVkZSA8bGludXgvbW9kdmVyc2lvbnMuaD4KCnN0YXRpYyB2b2lkIGludGhu
ZCAoaW50IGlycSwgdm9pZCAqZGV2LCBzdHJ1Y3QgcHRfcmVncyAqcmVncykKewoJcmV0dXJuOwp9
CgppbnQgaW5pdF9tb2R1bGUodm9pZCkKewoJaW50IGM7CgoJcHJpbnRrKCJpbnR0ZXN0IHN0YXJ0
XG4iKTsKCglmb3IgKGMgPSAwOyBjIDwgMTAwMDAwOyBjKyspIHsKCQlpZiAocmVxdWVzdF9pcnEo
IDgsIGludGhuZCwgMCwgImludHRlc3QiLCBOVUxMKSAhPSAwKSB7CgkJCXByaW50aygiaW50dGVz
dDogJWQgY2Fubm90IHJlcXVlc3QgaXJxXG4iLCBjKTsKCQkJYnJlYWs7CgkJfQoJCWZyZWVfaXJx
KDgsIE5VTEwpOwoJfQoJcHJpbnRrKCJpbnR0ZXN0IHN0b3BcbiIpOwoKCXJldHVybiAwOwp9Cgp2
b2lkIGNsZWFudXBfbW9kdWxlKHZvaWQpCnsKCXByaW50aygiaW50dGVzdCBjbGVhbnVwXG4iKTsK
fQo=

--0__=4EBBE150DFDD6B798f9e8a93df938690918c4EBBE150DFDD6B79--


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
