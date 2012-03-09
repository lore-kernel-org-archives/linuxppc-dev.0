Return-Path: <sfr@canb.auug.org.au>
Received: from members.tip.net.au (haggis.tip.net.au
 [IPv6:2402:b800:7003:1::20])
 by ozlabs.org (Postfix) with ESMTP id F2754B6FBC
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Mar 2012 15:41:06 +1100 (EST)
Date: Fri, 9 Mar 2012 15:40:50 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@elte.hu>,
 "H. Peter Anvin" <hpa@zytor.com>, Peter Zijlstra <peterz@infradead.org>
Subject: linux-next: manual merge of the tip tree with the powerpc tree
Message-Id: <20120309154050.6c7921999366c42cd1d15446@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature";
 micalg="PGP-SHA256";
 boundary="Signature=_Fri__9_Mar_2012_15_40_50_+1100_k_kpnCoKBhx6fCBX"
Cc: linux-next@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--Signature=_Fri__9_Mar_2012_15_40_50_+1100_k_kpnCoKBhx6fCBX
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tip tree got a conflict in
arch/powerpc/platforms/iseries/setup.c between commit 8ee3e0d69623
("powerpc: Remove the main legacy iSerie platform code") from the powerpc
tree and commit bd2f55361f18 ("sched/rt: Use schedule_preempt_disabled()")
from the tip tree.

The former removed the file, so I did that.
--=20
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

--Signature=_Fri__9_Mar_2012_15_40_50_+1100_k_kpnCoKBhx6fCBX
Content-Type: application/pgp-signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)

iQIcBAEBCAAGBQJPWYnSAAoJEECxmPOUX5FEQEUP/0FpHjy6Wsr79Vu38PHSw72N
iqZSobTXGyprfZePCBWKP6/+kcVSPYvoz0+yJVqA1XPI7U4evJqlmnt82+ujK28a
W1XbOzPCp82OLpVyR7llJ98+TXF8nzV8brG5ZUekOnYN9K5mGE2B5K5paETd+eVu
6+9ThpZAClNW/U/nV/c48Hno1/jWQ9wCDSMAtayli9sNMLzVkO2GK4+uar4khnzI
Q5iU6hyZfjYi9QnPse8XsBxOgJeSwyIgSYF3h8au9ue2Dhti3rlBj/83lNAa7lZ9
+Z40l7373a6/M3RSoY7BYNAZc4qjjwiBggV8whfcrPSn2Y46HCF3p84L4NfV/sEP
7NIAxUSOtsNFh4M6alTaWAe5iqSb9nBajnFb/ymDlB5bNyZIjElJVuRxMFpkvtAj
1aYhXa0V0VLXeEQJDOaDB5s3lFZcnPRsIEMCIS1QZLccBkwjEL7Nbdui+FmvCPFm
xzN08h3xK3l7SlGDqMQ30wtptnIQpHdJQMfnQKVXmMacINK+BOyaicMM6r6lZTUX
Ixaey5nh4b0wb7DuqU09ZW41f5E/u/VglroeIXM2PBzSoqFbbwQW3jfl1ETxU9KG
AYYp6x87FJTkJPP8CKi2YrJd8jNrJAx27irpWcwC7ExfXLqChI/sHSzOPsZ4m0SN
BbU+uZv9eLg90SGaZK+a
=UZMA
-----END PGP SIGNATURE-----

--Signature=_Fri__9_Mar_2012_15_40_50_+1100_k_kpnCoKBhx6fCBX--
