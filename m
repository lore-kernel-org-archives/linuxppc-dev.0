Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id AD2C7DDF59
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jun 2007 08:44:37 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] Create add_rtc() function to enable the RTC CMOS driver
Date: Thu, 7 Jun 2007 00:44:34 +0200
References: <1181147873.5674.116.camel@rhino>
In-Reply-To: <1181147873.5674.116.camel@rhino>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706070044.35056.arnd@arndb.de>
Cc: paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gV2VkbmVzZGF5IDA2IEp1bmUgMjAwNywgV2FkZSBGYXJuc3dvcnRoIHdyb3RlOgo+ICsKPiAr
oKCgoKCgoG5wID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwgInBucFBOUCxi
MDAiKTsKPiAroKCgoKCgoGlmICghbnApCj4gK6CgoKCgoKCgoKCgoKCgoHJldHVybiAtRU5PREVW
Owo+ICsKPiAroKCgoKCgoGlmIChvZl9hZGRyZXNzX3RvX3Jlc291cmNlKG5wLCAwLCAmcmVzKSkg
ewo+ICugoKCgoKCgoKCgoKCgoKBvZl9ub2RlX3B1dChucCk7Cj4gK6CgoKCgoKCgoKCgoKCgoHJl
dHVybiAtRU5PREVWOwo+ICugoKCgoKCgfQo+ICsKPiAroKCgoKCgoHBkID0gcGxhdGZvcm1fZGV2
aWNlX3JlZ2lzdGVyX3NpbXBsZSgicnRjX2Ntb3MiLCAtMSwKPiAroKCgoKCgoKCgoKCgoKCgoKCg
oKCgoKCgoKCgoKCgoKCgoKCgoKCgIKAgoCAmcmVzLCAxKTsKCkRvZXNuJ3QgdGhpcyBjb25mbGlj
dCB3aXRoIGEgcG90ZW50aWFsIGlzYXBucCBkcml2ZXIgZm9yIHRoZSBzYW1lCmRldmljZT8gSWYg
eW91IGhhdmUgbXVsdGlwbGUgaXNhcG5wIGRldmljZXMsIGl0IG1heSBiZSBiZXR0ZXIKdG8gYWRk
IGEgYnVzIGRyaXZlciBmb3IgdGhlIGlzYXBucCBob3N0LCBhbmQgdXNlIGRldmljZSBkcml2ZXJz
CmZvciB0aGF0IGJ1cyBpbnN0ZWFkIG9mIHBsYXRmb3JtIGRldmljZXMuCgoJQXJuZCA8PjwK
