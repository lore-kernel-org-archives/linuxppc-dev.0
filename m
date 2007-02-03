Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 61F8BDDE33
	for <linuxppc-dev@ozlabs.org>; Sat,  3 Feb 2007 19:28:12 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] [4/9] pasemi: Idle loops
Date: Sat, 3 Feb 2007 09:27:49 +0100
References: <20070202045448.145851000@lixom.net>
	<20070202045448.145851000@lixom.net>>
	<20070202045508.379230000@lixom.net>>
In-Reply-To: <20070202045508.379230000@lixom.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200702030927.49659.arnd@arndb.de>
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gRnJpZGF5IDAyIEZlYnJ1YXJ5IDIwMDcgMDU6NTQsIE9sb2YgSm9oYW5zc29uIHdyb3RlOgo+
ICtzdGF0aWMgdm9pZCBwYXNlbWlfaWRsZSh2b2lkKQo+ICt7Cj4gK6CgoKCgoKB3aGlsZSAoMSkg
ewo+ICugoKCgoKCgoKCgoKCgoKAvKiBYWFhPSk4gb3Byb2ZpbGUgb2ZmPyAqLwo+ICugoKCgoKCg
oKCgoKCgoKB3aGlsZSAoIW5lZWRfcmVzY2hlZCgpKQo+ICugoKCgoKCgoKCgoKCgoKCgoKCgoKCg
oG1vZGVzW2N1cnJlbnRfbW9kZV0uZW50cnkoKTsKPiArCj4gK6CgoKCgoKCgoKCgoKCgoC8qIFhY
WE9KTiBvcHJvZmlsZSBvbj8gKi8KPiAroKCgoKCgoKCgoKCgoKCgcHJlZW1wdF9lbmFibGVfbm9f
cmVzY2hlZCgpOwo+ICugoKCgoKCgoKCgoKCgoKBzY2hlZHVsZSgpOwo+ICugoKCgoKCgoKCgoKCg
oKBwcmVlbXB0X2Rpc2FibGUoKTsKPiAroKCgoKCgoH0KPiArfQoKQ2FuIHlvdSBkbyB0aGlzIHVz
aW5nIGEgcG93ZXJfc2F2ZSgpIGNhbGxiYWNrIGluc3RlYWQgb2YKYW4gaWRsZSgpIGNhbGxiYWNr
PyBXZSd2ZSBhbHJlYWR5IG1vdmVkIG92ZXIgcHJhY3RpY2FsbHkKYWxsIHBsYXRmb3JtcyB0byBw
b3dlcl9zYXZlKCksIGl0IHdvdWxkIGJlIGdvb2QgdG8Ka2lsbCBvZmYgdGhlIHBwY19tZC5pZGxl
KCkgZnVuY3Rpb24gYXMgc29vbiBhcyBpdCdzCnVubmVlZGVkLgoKCUFybmQgPD48Cg==
