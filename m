Return-Path: <arnd@arndb.de>
From: Arnd Bergmann <arnd@arndb.de>
To: cbe-oss-dev@ozlabs.org
Subject: Re: [Cbe-oss-dev] [RFC 3/3] powerpc: copy_4K_page tweaked for Cell
Date: Thu, 19 Jun 2008 23:28:50 +0200
References: <200806191754.17289.markn@au1.ibm.com>
In-Reply-To: <200806191754.17289.markn@au1.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200806192328.51423.arnd@arndb.de>
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org,
	Gunnar von Boehn <VONBOEHN@de.ibm.com>,
	Michael Ellerman <ellerman@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1cnNkYXkgMTkgSnVuZSAyMDA4LCBNYXJrIE5lbHNvbiB3cm90ZToKPiCgoKCgoKCgoC5h
bGlnbiCgNwo+IF9HTE9CQUwoY29weV80S19wYWdlKQo+IKCgoKCgoKCgZGNidKCgoKAwLHI0oKCg
oKCgoKCgoKCgLyogUHJlZmV0Y2ggT05FIFNSQyBjYWNoZWxpbmUgKi8KPiAKPiCgoKCgoKCgoGFk
ZGmgoKCgcjYscjMsLTigoKCgoKCgoC8qIHByZXBhcmUgZm9yIHN0ZHUgKi8KPiCgoKCgoKCgoGFk
ZGmgoKCgcjQscjQsLTigoKCgoKCgoC8qIHByZXBhcmUgZm9yIGxkdSAqLwo+IAo+IKCgoKCgoKCg
bGmgoKCgoKByMTAsMzKgoKCgoKCgoKCgLyogY29weSAzMiBjYWNoZSBsaW5lcyBmb3IgYSA0SyBw
YWdlICovCj4goKCgoKCgoKBsaaCgoKCgoHIxMiwxMjgrOKCgoKCgoKCgoKCgoKCgoC8qIHByZWZl
dGNoIGRpc3RhbmNlKi8KClNpbmNlIHlvdSBoYXZlIGEgbG9vcCBoZXJlIGFueXdheSBpbnN0ZWFk
IG9mIHRoZSBmdWxseSB1bnJvbGxlZApjb2RlLCB3aHkgbm90IHByb3ZpZGUgYSBjb3B5XzY0S19w
YWdlIGZ1bmN0aW9uIGFzIHdlbGwsIGp1bXBpbmcgaW4KaGVyZT8KClRoZSBpbmxpbmUgNjRrIGNv
cHlfcGFnZSBmdW5jdGlvbiBvdGhlcndpc2UganVzdCBhZGRzIGNvZGUgc2l6ZSwKYXMgd2VsbCBh
cyBiZWluZyBhIHRpbnkgYml0IHNsb3dlci4gSXQgbWF5IGV2ZW4gYmUgZ29vZCB0bwpoYXZlIGFu
IG91dC1vZi1saW5lIGNvcHlfNjRLX3BhZ2UgZm9yIHRoZSByZWd1bGFyIGNvZGUsIGp1c3QKY2Fs
bGluZyBjb3B5XzRLX3BhZ2UgcmVwZWF0ZWRseS4KCglBcm5kIDw+PAo=
