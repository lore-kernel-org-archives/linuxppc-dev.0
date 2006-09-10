Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id 3059B67B93
	for <linuxppc-dev@ozlabs.org>; Sun, 10 Sep 2006 10:31:15 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC] inline hypercall implementation for pseries
Date: Sun, 10 Sep 2006 02:31:02 +0200
References: <200609100042.54291.arnd@arndb.de>
In-Reply-To: <200609100042.54291.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200609100231.03373.arnd@arndb.de>
Cc: paulus@samba.org, anton@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gU3VuZGF5IDEwIFNlcHRlbWJlciAyMDA2IDAwOjQyLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgo+
ICugoKCgoKCgLyogZ2V0IHRpbWUgYW5kIFBVUlIgc25hcHNob3RzIGFmdGVyIGhjYWxsICovCj4g
K6CgoKCgoKBtZnRioKCgoHIxNKCgoKCgoKCgoKCgoKCgoKCgoKCgoC8qIHRpbWViYXNlIGFmdGVy
ICovCj4gK6CgoKCgoKBzdWJmoKCgoHIxNSxyMTUscjE0oKCgoKCgoKCgoKCgoC8qIHRpbWUgZGVs
dGEgKi8KPiArQkVHSU5fRlRSX1NFQ1RJT04KPiAroKCgoKCgoG1mc3ByoKCgcjE0LFNQUk5fUFVS
UqCgoKCgoKCgoKCgLyogUFVSUiBhZnRlciAqLwo+ICugoKCgoKCgc3ViZqCgoKByMTYscjE2LHIx
NKCgoKCgoKCgoKCgoKAvKiBkZWx0YSAqLwo+ICtFTkRfRlRSX1NFQ1RJT05fSUZDTFIoQ1BVX0ZU
Ul9QVVJSKQo+ICsKPiAroKCgoKCgoC8qIHVwZGF0ZSBzdGF0c6AqLwo+ICugoKCgoKCgbGSgoKCg
oKByMTQsSENBTExfU1RBVF9DQUxMUyhyMTMpIC8qIGNvdW50ICovCj4gK6CgoKCgoKBhZGRpoKCg
oHIxNCxyMTQsMQo+ICugoKCgoKCgc3RkoKCgoKByMTQsSENBTExfU1RBVF9DQUxMUyhyMTMpCj4g
K6CgoKCgoKBsZCCgIKAgoHIxNCxIQ0FMTF9TVEFUX1RCKHIxMymgoC8qIHRpbWViYXNlICovCj4g
K6CgoKCgoKBhZGSgoKCgoHIxNCxyMTQscjUKPiAroKCgoKCgoHN0ZKCgoKCgcjE0LEhDQUxMX1NU
QVRfVEIocjEzKQo+ICtCRUdJTl9GVFJfU0VDVElPTgo+ICugoKCgoKCgbGSgoKCgoKByMTQsSENB
TExfU1RBVF9QVVJSKHIxMykvKiBQVVJSICovCj4gK6CgoKCgoKBhZGSgoKCgoHIxNCxyMTQscjYK
PiAroKCgoKCgoHN0ZKCgoKCgcjE0LEhDQUxMX1NUQVRfUFVSUihyMTMpCj4gK0VORF9GVFJfU0VD
VElPTl9JRkNMUihDUFVfRlRSX1BVUlIpCgoKSG1tLCBzZWVtcyBJIGN1dCB0b28gbXVjaCB0aGVy
ZSwgaXQgc2hvdWxkIGF0IGxlYXN0IGNvbnRhaW4KYSBIVlNDIGluc3RydWN0aW9uLCBhZnRlciB0
aGUgZmlyc3QgRU5EX0ZUUl9TRUNUSU9OLiBJdCBtYXkKYWxzbyBiZSBiZXR0ZXIgdG8gdXNlIGhp
Z2hlciByZWdpc3RlcnMgaW5zdGVhZCBvZiByMTMuLi5yMTYuCgoJQXJuZCA8PjwK
