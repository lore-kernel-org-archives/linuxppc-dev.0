Return-Path: <dcb314@hotmail.com>
Received: from blu0-omc1-s31.blu0.hotmail.com (blu0-omc1-s31.blu0.hotmail.com
	[65.55.116.42]) by ozlabs.org (Postfix) with ESMTP id 94CD0B7BFA
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 21:12:24 +1100 (EST)
Message-ID: <BLU108-W15D28ACC0F582E99E06AC99C2A0@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_8a8115d0-15ea-42c5-8161-25943d973e94_"
From: d binderman <dcb314@hotmail.com>
To: <johannes@sipsolutions.net>
Subject: [PATCH]: core/gpio-pmf.c: 3 * redundant code
Date: Fri, 19 Mar 2010 10:12:22 +0000
MIME-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--_8a8115d0-15ea-42c5-8161-25943d973e94_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable




 		 	   		 =20
_________________________________________________________________
Send us your Hotmail stories and be featured in our newsletter
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_8a8115d0-15ea-42c5-8161-25943d973e94_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug45.patch"

ClNpZ25lZC1vZmYtYnk6IERhdmlkIEJpbmRlcm1hbiA8ZGNiMzE0QGhvdG1haWwuY29tPgoKLS0t
IGFvYS9jb3JlL2dwaW8tcG1mLmMuc2F2CTIwMTAtMDMtMTkgMTA6MDc6MzAuMDAwMDAwMDAwICsw
MDAwCisrKyBhb2EvY29yZS9ncGlvLXBtZi5jCTIwMTAtMDMtMTkgMTA6MDc6NDAuMDAwMDAwMDAw
ICswMDAwCkBAIC0xMTUsMTIgKzExNSw5IEBAIHN0YXRpYyB2b2lkIHBtZl9ncGlvX2V4aXQoc3Ry
dWN0IGdwaW9fcnUKIAltdXRleF9kZXN0cm95KCZydC0+bGluZV9pbl9ub3RpZnkubXV0ZXgpOwog
CW11dGV4X2Rlc3Ryb3koJnJ0LT5saW5lX291dF9ub3RpZnkubXV0ZXgpOwogCi0JaWYgKHJ0LT5o
ZWFkcGhvbmVfbm90aWZ5LmdwaW9fcHJpdmF0ZSkKLQkJa2ZyZWUocnQtPmhlYWRwaG9uZV9ub3Rp
ZnkuZ3Bpb19wcml2YXRlKTsKLQlpZiAocnQtPmxpbmVfaW5fbm90aWZ5LmdwaW9fcHJpdmF0ZSkK
LQkJa2ZyZWUocnQtPmxpbmVfaW5fbm90aWZ5LmdwaW9fcHJpdmF0ZSk7Ci0JaWYgKHJ0LT5saW5l
X291dF9ub3RpZnkuZ3Bpb19wcml2YXRlKQotCQlrZnJlZShydC0+bGluZV9vdXRfbm90aWZ5Lmdw
aW9fcHJpdmF0ZSk7CisJa2ZyZWUocnQtPmhlYWRwaG9uZV9ub3RpZnkuZ3Bpb19wcml2YXRlKTsK
KwlrZnJlZShydC0+bGluZV9pbl9ub3RpZnkuZ3Bpb19wcml2YXRlKTsKKwlrZnJlZShydC0+bGlu
ZV9vdXRfbm90aWZ5LmdwaW9fcHJpdmF0ZSk7CiB9CiAKIHN0YXRpYyB2b2lkIHBtZl9oYW5kbGVf
bm90aWZ5X2lycSh2b2lkICpkYXRhKQo=

--_8a8115d0-15ea-42c5-8161-25943d973e94_--
