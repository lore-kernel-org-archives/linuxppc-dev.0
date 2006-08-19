Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.177]) by ozlabs.org (Postfix) with ESMTP id B4E6A67B86
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Aug 2006 06:19:14 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] powerpc: emulate power5 popcntb instruction
Date: Sat, 19 Aug 2006 22:19:02 +0200
References: <1155840829.9659.16.camel@farscape.rchland.ibm.com>
	<200608182105.45264.arnd@arndb.de>
	<50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
In-Reply-To: <50883.84.105.60.119.1156014614.squirrel@gate.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608192219.03178.arnd@arndb.de>
Cc: paulus@samba.org, segher@gate.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gU2F0dXJkYXkgMTkgQXVndXN0IDIwMDYgMjE6MTAsIHNlZ2hlckBnYXRlLmNyYXNoaW5nLm9y
ZyB3cm90ZToKPiA+IElzIHRoYXQgdGhlIHJpZ2h0IGNoZWNrPyBUaGUgb3RoZXIgc2ltaWxhciB0
cmFwcyBjaGVjayBhZ2FpbnN0IGEKPiA+IG1hc2sgb2YgMHg3YzAwMDdmZS4KPiAKPiBJIGhvcGUg
eW91IG1lYW4gMHhmYzAwMDdmZT8KPiAKCk5vLCB0aGUgY29kZSBpbiBxdWVzdGlvbiBpcyAKCiNk
ZWZpbmUgSU5TVF9NRlNQUl9QVlKtt623t7e3t7e3MHg3YzFmNDJhNgojZGVmaW5lIElOU1RfTUZT
UFJfUFZSX01BU0utt7e3tzB4ZmMxZmZmZmYKCiNkZWZpbmUgSU5TVF9EQ0JBrbe3t7e3t623t7e3
t7e3MHg3YzAwMDVlYwojZGVmaW5lIElOU1RfRENCQV9NQVNLrbett7e3t7e3tzB4N2MwMDA3ZmUK
CiNkZWZpbmUgSU5TVF9NQ1JYUq23t7e3t623t7e3t7e3MHg3YzAwMDQwMAojZGVmaW5lIElOU1Rf
TUNSWFJfTUFTS62tt7e3t7e3tzB4N2MwMDA3ZmUKCiNkZWZpbmUgSU5TVF9TVFJJTkett7e3t623
t7e3t7e3MHg3YzAwMDQyYQojZGVmaW5lIElOU1RfU1RSSU5HX01BU0utt7e3t7e3tzB4N2MwMDA3
ZmUKI2RlZmluZSBJTlNUX1NUUklOR19HRU5fTUFTS623t7cweDdjMDAwNjdlCiNkZWZpbmUgSU5T
VF9MU1dJrbe3t7e3t623t7e3t7e3MHg3YzAwMDRhYQojZGVmaW5lIElOU1RfTFNXWK23t7e3t7et
t7e3t7e3tzB4N2MwMDA0MmEKI2RlZmluZSBJTlNUX1NUU1dJrbe3t7e3rbe3t7e3t7cweDdjMDAw
NWFhCiNkZWZpbmUgSU5TVF9TVFNXWK23t7e3t623t7e3t7e3MHg3YzAwMDUyYQoKV2hhdCBkb2Vz
IHRoZSBNU0IgZG8gaW4gb3VyIGluc3RydWN0aW9ucz8KCglBcm5kIDw+PAo=
