Return-Path: <dcb314@hotmail.com>
Received: from blu0-omc3-s8.blu0.hotmail.com (blu0-omc3-s8.blu0.hotmail.com
	[65.55.116.83]) by ozlabs.org (Postfix) with ESMTP id 051A6B7D23
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Feb 2010 23:18:35 +1100 (EST)
Message-ID: <BLU108-W1270106CF117770B0ABB269C530@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_92a14115-59ee-4dd6-bbb1-4a29d875093f_"
From: d binderman <dcb314@hotmail.com>
To: <benh@kernel.crashing.org>
Subject: powermac/low_i2c.c: three minor problems
Date: Sat, 6 Feb 2010 12:13:29 +0000
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

--_92a14115-59ee-4dd6-bbb1-4a29d875093f_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello there=2C

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.33-rc6

It said

[./arch/powerpc/platforms/powermac/low_i2c.c:594]: (style) The scope of the=
 variable chans can be reduced
[./arch/powerpc/platforms/powermac/low_i2c.c:594]: (style) The scope of the=
 variable i can be reduced
[./arch/powerpc/platforms/powermac/low_i2c.c:1260]: (style) Redundant condi=
tion. It is safe to deallocate a NULL pointer

Please find attached a patch to fix these minor problems.=A0=20
The patched version compiles=2C but I have not been able to test it at run =
time.

Regards

David Binderman
 		 	   		 =20
_________________________________________________________________
Do you have a story that started on Hotmail? Tell us now
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_92a14115-59ee-4dd6-bbb1-4a29d875093f_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug30.patch"

LS0tIGFyY2gvcG93ZXJwYy9wbGF0Zm9ybXMvcG93ZXJtYWMvbG93X2kyYy5jLnNhdgkyMDEwLTAy
LTA2IDExOjUyOjIxLjAwMDAwMDAwMCArMDAwMAorKysgYXJjaC9wb3dlcnBjL3BsYXRmb3Jtcy9w
b3dlcm1hYy9sb3dfaTJjLmMJMjAxMC0wMi0wNiAxMTo1MzowNy4wMDAwMDAwMDAgKzAwMDAKQEAg
LTU5MSw3ICs1OTEsNyBAQCBzdGF0aWMgdm9pZCBfX2luaXQga3dfaTJjX3Byb2JlKHZvaWQpCiAJ
LyogUHJvYmUga2V5d2VzdC1pMmMgYnVzc2VzICovCiAJZm9yX2VhY2hfY29tcGF0aWJsZV9ub2Rl
KG5wLCAiaTJjIiwia2V5d2VzdC1pMmMiKSB7CiAJCXN0cnVjdCBwbWFjX2kyY19ob3N0X2t3ICpo
b3N0OwotCQlpbnQgbXVsdGlidXMsIGNoYW5zLCBpOworCQlpbnQgbXVsdGlidXM7CiAKIAkJLyog
Rm91bmQgb25lLCBpbml0IGEgaG9zdCBzdHJ1Y3R1cmUgKi8KIAkJaG9zdCA9IGt3X2kyY19ob3N0
X2luaXQobnApOwpAQCAtNjEzLDYgKzYxMyw4IEBAIHN0YXRpYyB2b2lkIF9faW5pdCBrd19pMmNf
cHJvYmUodm9pZCkKIAkJICogcGFyZW50IHR5cGUKIAkJICovCiAJCWlmIChtdWx0aWJ1cykgewor
CQkJaW50IGNoYW5zLCBpOworCiAJCQlwYXJlbnQgPSBvZl9nZXRfcGFyZW50KG5wKTsKIAkJCWlm
IChwYXJlbnQgPT0gTlVMTCkKIAkJCQljb250aW51ZTsKQEAgLTEyNTcsOCArMTI1OSw3IEBAIHN0
YXRpYyB2b2lkIHBtYWNfaTJjX2RvX2VuZChzdHJ1Y3QgcG1mX2YKIAlpZiAoaW5zdCA9PSBOVUxM
KQogCQlyZXR1cm47CiAJcG1hY19pMmNfY2xvc2UoaW5zdC0+YnVzKTsKLQlpZiAoaW5zdCkKLQkJ
a2ZyZWUoaW5zdCk7CisJa2ZyZWUoaW5zdCk7CiB9CiAKIHN0YXRpYyBpbnQgcG1hY19pMmNfZG9f
cmVhZChQTUZfU1REX0FSR1MsIHUzMiBsZW4pCg==

--_92a14115-59ee-4dd6-bbb1-4a29d875093f_--
