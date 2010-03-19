Return-Path: <dcb314@hotmail.com>
Received: from blu0-omc3-s11.blu0.hotmail.com (blu0-omc3-s11.blu0.hotmail.com
	[65.55.116.86]) by ozlabs.org (Postfix) with ESMTP id 5BA7CB7CB6
	for <linuxppc-dev@ozlabs.org>; Fri, 19 Mar 2010 20:06:48 +1100 (EST)
Message-ID: <BLU108-W19BF72C9933FC2647F761B9C2A0@phx.gbl>
Content-Type: multipart/mixed;
	boundary="_fa8e6bc2-9363-4a7a-8119-fef352e42553_"
From: d binderman <dcb314@hotmail.com>
To: <benh@kernel.crashing.org>
Subject: [PATCH]: Minor quibble in macintosh/windfarm_pm81.c
Date: Fri, 19 Mar 2010 09:01:42 +0000
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

--_fa8e6bc2-9363-4a7a-8119-fef352e42553_
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable



Hello there=2C

I just ran the sourceforge tool cppcheck over the source code of the
new Linux kernel 2.6.34-rc1

It said

[./macintosh/windfarm_pm81.c:760]: (style) Redundant condition. It is safe =
to deallocate a NULL poin
ter
[./macintosh/windfarm_pm81.c:762]: (style) Redundant condition. It is safe =
to deallocate a NULL poin
ter

The source code is

=A0=A0=A0=A0=A0=A0=A0 /* Destroy control loops state structures */
=A0=A0=A0=A0=A0=A0=A0 if (wf_smu_sys_fans)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(wf_smu_sys_fans)=3B
=A0=A0=A0=A0=A0=A0=A0 if (wf_smu_cpu_fans)
=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 kfree(wf_smu_cpu_fans)=3B

Proposed patch file attached.

Regards

David Binderman

 		 	   		 =20
_________________________________________________________________
Send us your Hotmail stories and be featured in our newsletter
http://clk.atdmt.com/UKM/go/195013117/direct/01/=

--_fa8e6bc2-9363-4a7a-8119-fef352e42553_
Content-Type: text/x-patch
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="bug39.patch"

ClNpZ25lZC1vZmYtYnk6IERhdmlkIEJpbmRlcm1hbiA8ZGNiMzE0QGhvdG1haWwuY29tPgoKLS0t
IG1hY2ludG9zaC93aW5kZmFybV9wbTgxLmMuc2F2CTIwMTAtMDMtMTkgMDg6NTc6MjIuMDAwMDAw
MDAwICswMDAwCisrKyBtYWNpbnRvc2gvd2luZGZhcm1fcG04MS5jCTIwMTAtMDMtMTkgMDg6NTc6
MzQuMDAwMDAwMDAwICswMDAwCkBAIC03NTcsMTAgKzc1Nyw4IEBAIHN0YXRpYyBpbnQgX19kZXZl
eGl0IHdmX3NtdV9yZW1vdmUoc3RydWMKIAkJd2ZfcHV0X2NvbnRyb2woY3B1ZnJlcV9jbGFtcCk7
CiAKIAkvKiBEZXN0cm95IGNvbnRyb2wgbG9vcHMgc3RhdGUgc3RydWN0dXJlcyAqLwotCWlmICh3
Zl9zbXVfc3lzX2ZhbnMpCi0JCWtmcmVlKHdmX3NtdV9zeXNfZmFucyk7Ci0JaWYgKHdmX3NtdV9j
cHVfZmFucykKLQkJa2ZyZWUod2Zfc211X2NwdV9mYW5zKTsKKwlrZnJlZSh3Zl9zbXVfc3lzX2Zh
bnMpOworCWtmcmVlKHdmX3NtdV9jcHVfZmFucyk7CiAKIAlyZXR1cm4gMDsKIH0K

--_fa8e6bc2-9363-4a7a-8119-fef352e42553_--
