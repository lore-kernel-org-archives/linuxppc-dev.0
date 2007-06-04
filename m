Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.179]) by ozlabs.org (Postfix) with ESMTP id 4CF17DDEE4
	for <linuxppc-dev@ozlabs.org>; Tue,  5 Jun 2007 03:12:06 +1000 (EST)
From: Arnd Bergmann <arnd@arndb.de>
To: linuxppc-dev@ozlabs.org
Subject: Re: [RFC/PATCH 4/4] Add support for MSI on Axon-based Cell systems
Date: Mon, 4 Jun 2007 19:12:04 +0200
References: <f0cd638495b96585dec513f41335154e60675813.1180961962.git.michael@ellerman.id.au>
	<90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
In-Reply-To: <90f8b99fa6a8e4b8898d64630d96036f68668b03.1180961962.git.michael@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200706041912.04651.arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gTW9uZGF5IDA0IEp1bmUgMjAwNywgTWljaGFlbCBFbGxlcm1hbiB3cm90ZToKPiAroKCgoKCg
oGZvcl9lYWNoX2NvbXBhdGlibGVfbm9kZShub2RlLCBOVUxMLCAiaWJtLGF4b24tbXNpYyIpIHsK
PiAroKCgoKCgoKCgoKCgoKCgaWYgKGF4b25fbXNpX3NldHVwX29uZShvZl9ub2RlX2dldChub2Rl
KSkgPT0gMCkKPiAroKCgoKCgoKCgoKCgoKCgoKCgoKCgoKBmb3VuZCsrOwo+ICugoKCgoKCgfQo+
ICugoKCgoKCgb2Zfbm9kZV9wdXQobm9kZSk7CgpPbmUgbW9yZSB0aGluZzogQUZBSUNTICdub2Rl
JyBpcyBndWFyYW50ZWVkIHRvIGJlIE5VTEwgd2hlbiB5b3UgZ2V0Cm91dCBvZiB0aGUgZm9yX2Vh
Y2hfY29tcGF0aWJsZV9ub2RlIGxvb3AsIHNvIHlvdSBkb24ndCBuZWVkIHRoZQpvZl9ub2RlX3B1
dCgpLgoKCUFybmQgPD48Cg==
