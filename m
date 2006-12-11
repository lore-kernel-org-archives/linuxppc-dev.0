Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id 3172067C8C
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 01:18:55 +1100 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH] libata: don't initialize sg in ata_exec_internal() if
	DMA_NONE
Date: Mon, 11 Dec 2006 15:18:46 +0100
References: <200612081914.41810.arnd.bergmann@de.ibm.com>
	<20061211140258.GB18947@htj.dyndns.org>
In-Reply-To: <20061211140258.GB18947@htj.dyndns.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612111518.46887.arnd@arndb.de>
Cc: linux-ide@vger.kernel.org, Tejun Heo <htejun@gmail.com>, jgarzik@pobox.com,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gTW9uZGF5IDExIERlY2VtYmVyIDIwMDYgMTU6MDIsIFRlanVuIEhlbyB3cm90ZToKPiCgewo+
IKCgoKCgoKCgc3RydWN0IHNjYXR0ZXJsaXN0IHNnOwo+ICugoKCgoKCgdW5zaWduZWQgaW50IG5f
ZWxlbSA9IDA7Cj4goAo+IC2goKCgoKCgc2dfaW5pdF9vbmUoJnNnLCBidWYsIGJ1Zmxlbik7Cj4g
K6CgoKCgoKBpZiAoZG1hX2RpciAhPSBETUFfTk9ORSkgewo+ICugoKCgoKCgoKCgoKCgoKBXQVJO
X09OKCFidWYpOwo+ICugoKCgoKCgoKCgoKCgoKBzZ19pbml0X29uZSgmc2csIGJ1ZiwgYnVmbGVu
KTsKPiAroKCgoKCgoKCgoKCgoKCgbl9lbGVtKys7Cj4gK6CgoKCgoKB9Cj4goApPaywgbG9va3Mg
Z29vZCBhcyB3ZWxsLiBJIHN0aWxsIHRoaW5rIHdlIHNob3VsZCBoYXZlIHRoZSBXQVJOX09OKCkK
aW4gc2dfc2V0X2J1ZigpLCBidXQgSSBjYW4gc2VuZCBhIHNlcGFyYXRlIHBhdGNoIGZvciB0aGF0
IHRvIGxpbnV4LW1tLgoKCUFybmQgPD48Cg==
