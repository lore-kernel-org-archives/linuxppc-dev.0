Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [patch 6/6] mtd/ps3vram: Use msleep in waits
Date: Wed, 7 Jan 2009 20:25:23 +0100
References: <4963CA52.9030902@am.sony.com> <4963CDF4.1070403@am.sony.com>
In-Reply-To: <4963CDF4.1070403@am.sony.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200901072025.24791.arnd@arndb.de>
Cc: David Woodhouse <David.Woodhouse@intel.com>, Jim Paris <jim@jtan.com>,
	Vivien Chappelier <vivien.chappelier@free.fr>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVHVlc2RheSAwNiBKYW51YXJ5IDIwMDksIEdlb2ZmIExldmFuZCB3cm90ZToKPiCgoKCgoKCg
oGRvIHsKPiAtoKCgoKCgoKCgoKCgoKCgaWYgKG5vdGlmeVszXSA9PSAwKQo+ICugoKCgoKCgoKCg
oKCgoKBpZiAoIW5vdGlmeVszXSkKPiCgoKCgoKCgoKCgoKCgoKCgoKCgoKCgoKByZXR1cm4gMDsK
PiAtCj4gLaCgoKCgoKCgoKCgoKCgoGlmICh0aW1lb3V0X21zKQo+IC2goKCgoKCgoKCgoKCgoKCg
oKCgoKCgoHVkZWxheSgxKTsKPiAroKCgoKCgoKCgoKCgoKCgbXNsZWVwKDEpOwo+IKCgoKCgoKCg
fSB3aGlsZSAodGltZW91dF9tcy0tKTsKPiCgCgpJIGd1ZXNzIGl0J3Mgbm90IHJlYWxseSBpbXBv
cnRhbnQsIGJ1dCB0aGlzIGZ1bmN0aW9uIG1pZ2h0IHdhaXQgc3Vic3RhbnRpYWxseQpsb25nZXIg
dGhhbiByZXF1ZXN0ZWQuIElmIHlvdSBoYXZlIENPTkZJR19IWj0xMDAsIG1zbGVlcCgxKSB3aWxs
IHNsZWVwIGZvcgphdCBsZWFzdCAxMCBtaWxpc2Vjb25kcy4gVGhlIGNvcnJlY3Qgd2F5IHRvIHNs
ZWVwIGZvciB1cCB0byBhIGdpdmVuIGFtb3VudApvZiB0aW1lIGlzIHRvIGNhbGN1bGF0ZSB0aGUg
ZW5kIHRpbWUgaW4gamlmZmllcywgYW5kIHVzZSB0aW1lX2JlZm9yZSgpIGluCnRoZSBsb29wIGNv
bmRpdGlvbi4KCglBcm5kIDw+PAo=
