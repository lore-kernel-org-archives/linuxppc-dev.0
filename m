Return-Path: <nicolas@det-net.org>
Received: from natklopstock.rzone.de (natklopstock.rzone.de [81.169.145.174])
	by ozlabs.org (Postfix) with ESMTP id 8AE0A679E1
	for <linuxppc-dev@ozlabs.org>; Sun,  6 Aug 2006 19:06:04 +1000 (EST)
Date: Sun, 6 Aug 2006 10:42:00 +0200
From: Nicolas DET <nicolas@det-net.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] cputable: Correct IBM/750CXe rev3.x setup
Message-Id: <20060806104200.49c5f6bf.nicolas@det-net.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="Multipart=_Sun__6_Aug_2006_10_42_00_+0200_LeA8gecv3FoLbwPr"
Cc: akpm@osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This is a multi-part message in MIME format.

--Multipart=_Sun__6_Aug_2006_10_42_00_+0200_LeA8gecv3FoLbwPr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

This patch simply add an entry in the cputable to recognize correctly the IBM750CXe rev3.1. Only rev 2.x was correctly detected before.

Your sincerly
Nicolas DET

--Multipart=_Sun__6_Aug_2006_10_42_00_+0200_LeA8gecv3FoLbwPr
Content-Type: application/octet-stream;
 name="powerpc_750cxe_rev3.patch"
Content-Disposition: attachment;
 filename="powerpc_750cxe_rev3.patch"
Content-Transfer-Encoding: base64

LS0tIGxpbnV4LTIuNi4xNy43Lm9yaWcvYXJjaC9wb3dlcnBjL2tlcm5lbC9jcHV0YWJsZS5jCTIw
MDYtMDctMjUgMDU6MzY6MDEuMDAwMDAwMDAwICswMjAwCisrKyBsaW51eC0yLjYuMTcuN19uaWNv
L2FyY2gvcG93ZXJwYy9rZXJuZWwvY3B1dGFibGUuYwkyMDA2LTA4LTA2IDA3OjUwOjI5LjAwMDAw
MDAwMCArMDIwMApAQCAtNDQ3LDYgKzQ0NywxOCBAQAogCQkuY3B1X3NldHVwCQk9IF9fc2V0dXBf
Y3B1Xzc1MGN4LAogCQkucGxhdGZvcm0JCT0gInBwYzc1MCIsCiAJfSwKKwl7CS8qIDc1MENYZSBy
ZXYgMy4xICgwMDA4eDMxMSkgKi8KKwkJLnB2cl9tYXNrCQk9IDB4ZmZmZjBmZmYsCisJCS5wdnJf
dmFsdWUJCT0gMHgwMDA4MDMxMSwKKwkJLmNwdV9uYW1lCQk9ICI3NTBDWGUiLAorCQkuY3B1X2Zl
YXR1cmVzCQk9IENQVV9GVFJTXzc1MCwKKwkJLmNwdV91c2VyX2ZlYXR1cmVzCT0gQ09NTU9OX1VT
RVIsCisJCS5pY2FjaGVfYnNpemUJCT0gMzIsCisJCS5kY2FjaGVfYnNpemUJCT0gMzIsCisJCS5u
dW1fcG1jcwkJPSA0LAorCQkuY3B1X3NldHVwCQk9IF9fc2V0dXBfY3B1Xzc1MGN4LAorCQkucGxh
dGZvcm0JCT0gInBwYzc1MCIsCisJfSwKIAl7CS8qIDc1MENYZSAiR2Vra28iICg4MzIxNCkgKi8K
IAkJLnB2cl9tYXNrCQk9IDB4ZmZmZmZmZmYsCiAJCS5wdnJfdmFsdWUJCT0gMHgwMDA4MzIxNCwK

--Multipart=_Sun__6_Aug_2006_10_42_00_+0200_LeA8gecv3FoLbwPr--
