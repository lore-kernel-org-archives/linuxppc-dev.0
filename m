Return-Path: <timur.tabi@gmail.com>
Received: from mail-gx0-f21.google.com (mail-gx0-f21.google.com
	[209.85.217.21]) by ozlabs.org (Postfix) with ESMTP id 65373DE3D5
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Oct 2008 03:20:10 +1100 (EST)
Received: by gxk14 with SMTP id 14so214409gxk.9
	for <linuxppc-dev@ozlabs.org>; Thu, 09 Oct 2008 09:20:09 -0700 (PDT)
Message-ID: <ed82fe3e0810090920t25442258gcd5cedabf686fe2d@mail.gmail.com>
Date: Thu, 9 Oct 2008 11:20:09 -0500
From: "Timur Tabi" <timur@freescale.com>
Sender: timur.tabi@gmail.com
To: "Matt Sealey" <matt@genesi-usa.com>
Subject: Re: [PATCH] powerpc: remove default=y from PMAC and CHRP Kconfigs
In-Reply-To: <48EE2A49.10405@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=KOI8-R
References: <1223495845-14149-1-git-send-email-timur@freescale.com>
	<1223496186.8157.82.camel@pasglop>
	<ed82fe3e0810081314g34b902f7j76f5049faf91f905@mail.gmail.com>
	<1223498380.8157.86.camel@pasglop> <48ED1B9E.3020907@freescale.com>
	<48EE2A49.10405@genesi-usa.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

T24gVGh1LCBPY3QgOSwgMjAwOCBhdCAxMDo1OSBBTSwgTWF0dCBTZWFsZXkgPG1hdHRAZ2VuZXNp
LXVzYS5jb20+IHdyb3RlOgoKPiBJZiB5b3UgcmVhbGx5IHdhbnQgdG8gYnVpbGQgYSBzaW5nbGUt
Y3B1IHNpbmdsZS1ib2FyZCBrZXJuZWwsIGRpc2FibGUgQ0hSUAo+IGFuZCBQTUFDIGZvciB0aG9z
ZSBib2FyZCBjb25maWdzLCBidXQgdGhlIGRlZmF1bHQgZGVmaW5pdGVseSBzaG91bGQgYmUgdG8K
PiBlbmFibGUgdGhlbSBhbGwgd2l0aGluIHJlYXNvbgoKVGhlIHByb2JsZW0gaXMgdGhhdCB0aGlz
IGlzIGluY29uc2lzdGVudCB3aXRoIG1vc3QgS2NvbmZpZyBvcHRpb25zLgpMYXN0IEkgaGVhcmQs
IHRoZSBrZXJuZWwgY29tbXVuaXR5IGdlbmVyYWxseSBmcm93bnMgb24gImRlZmF1bHQgeSIgaW4K
S2NvbmZpZyBvcHRpb25zLgoKSSdtIHdhaXRpbmcgZm9yIHNvbWVvbmUgdG8gZXhwbGFpbiB0byBt
ZSB3aGF0J3Mgc28gc3BlY2lhbCBhYm91dCBDSFJQCmFuZCBQTUFDIHRoYXQgdGhlc2UgdHdvIHBs
YXRmb3JtcyBzaG91bGQgYmUgZW5hYmxlZCBieSBkZWZhdWx0LCB3aGVuCmFsbCBvdGhlciBQb3dl
clBDIHBsYXRmb3JtcyBhcmUgZGlzYWJsZWQgYnkgZGVmYXVsdC4KClRoaXMgaXMgd2hhdCBJIHNl
ZSBpbiBtZW51Y29uZmlnIHdoZW4gSSBjcmVhdGUgYSBmcmVzaCAuY29uZmlnIGZvciBQb3dlclBD
OgoKICCBIIEgICAgWypdIENvbW1vbiBIYXJkd2FyZSBSZWZlcmVuY2UgUGxhdGZvcm0gKENIUlAp
IGJhc2VkIG1hY2hpbmVzIChORVcpCiAggSCBICAgIFsgXSBGcmVlc2NhbGUgTVBDNTEyMUUgQURT
IChORVcpCiAggSCBICAgIFsgXSBHZW5lcmljIHN1cHBvcnQgZm9yIHNpbXBsZSBNUEM1MTIxIGJh
c2VkIGJvYXJkcyAoTkVXKQogIIEggSAgICBbIF0gNTJ4eC1iYXNlZCBib2FyZHMgKE5FVykKICCB
IIEgICAgWypdIEFwcGxlIFBvd2VyTWFjIGJhc2VkIG1hY2hpbmVzIChORVcpCiAggSCBICAgIFsg
XSA4Mnh4LWJhc2VkIGJvYXJkcyAoUFEgSUkpIChORVcpICAtLS0+CiAggSCBICAgIFsgXSA4M3h4
LWJhc2VkIGJvYXJkcyAoTkVXKSAgLS0tPgogIIEggSAgICBbIF0gODZ4eC1iYXNlZCBib2FyZHMg
KE5FVykgIC0tLT4KICCBIIEgICAgWyBdIEVtYmVkZGVkIDZ4eC83eHgvN3h4eC1iYXNlZCBib2Fy
ZHMgKE5FVykKCkNIUlAgYW5kIFBNQUMgYXJlbid0IGZvbGxvd2luZyB0aGUgcnVsZXMgdGhhdCBl
dmVyeW9uZSBlbHNlIGlzIGZvbGxvd2luZy4gIFdoeT8KCi0tIApUaW11ciBUYWJpCkxpbnV4IGtl
cm5lbCBkZXZlbG9wZXIgYXQgRnJlZXNjYWxlCg==
