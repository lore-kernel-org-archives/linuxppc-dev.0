Return-Path: <sparking.lu@gmail.com>
Received: from zproxy.gmail.com (zproxy.gmail.com [64.233.162.201])
	by ozlabs.org (Postfix) with ESMTP id ED2F967A5B
	for <linuxppc-dev@ozlabs.org>; Thu,  6 Apr 2006 00:32:24 +1000 (EST)
Received: by zproxy.gmail.com with SMTP id k1so556306nzf
	for <linuxppc-dev@ozlabs.org>; Wed, 05 Apr 2006 07:32:23 -0700 (PDT)
Message-ID: <e9aafa30604050732g6ede1f37h450243613bcbca85@mail.gmail.com>
Date: Wed, 5 Apr 2006 22:32:23 +0800
From: "fengcheng lu" <sparking.lu@gmail.com>
To: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Anybody applied the patch "Add 85xx CDS to arch/powerpc" on the
	2.6.16. I failed to apply it:-(
MIME-Version: 1.0
Content-Type: multipart/alternative;
	boundary="----=_Part_3609_21271391.1144247543163"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

------=_Part_3609_21271391.1144247543163
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

Hello all

    I downloaded this patch from
http://patchwork.ozlabs.org/linuxppc/patch?id=3D4910. But I failed to apply
it. The following is the output:
debian:/usr/src/linux-2.6.16# patch -p1 <powerpc.patch
patching file arch/powerpc/config/mpc85xx_cds_deconfig
patching file arch/powerpc/platforms/85xx/Kconfig
Hunk #1 FAILED at 11
1 out of 1 hunk FAILED -- saving rejects to file
arch/powerpc/platforms/85xx/Kconfig.rej
patching file arch/powerpc/platforms/85xx/Makefile
Hunk #1 FAILED at 3
1 out of 1 hunk FAILED -- saving rejects to file
arch/powerpc/platforms/85xx/Makefile.rej
patching file arch/powerpc/platforms/85xx/mpc85xx_cds.c
patching file arch/powerpc/platforms/85xx/mpc85xx_cds.h
patching file include/asm-ppc/mpc85xx.h

It looks seem the Makefile and Kconfig don't match yours.

Who have the successful patch experience. Thank you to tell me the right
procedure!

BTW: the patch command version is 2.5.4

Best Regards
Lu

------=_Part_3609_21271391.1144247543163
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Content-Disposition: inline

<div>Hello all</div>
<div>&nbsp;</div>
<div>&nbsp;&nbsp;&nbsp; I downloaded this patch from <a href=3D"http://patc=
hwork.ozlabs.org/linuxppc/patch?id=3D4910">http://patchwork.ozlabs.org/linu=
xppc/patch?id=3D4910</a>. But I failed to apply it. The following is the ou=
tput:<br>debian:/usr/src/linux-
2.6.16# patch -p1 &lt;powerpc.patch<br>patching file arch/powerpc/config/mp=
c85xx_cds_deconfig<br>patching file arch/powerpc/platforms/85xx/Kconfig<br>=
Hunk #1 FAILED at 11<br>1 out of 1 hunk FAILED -- saving rejects to file ar=
ch/powerpc/platforms/85xx/Kconfig.rej
<br>patching file arch/powerpc/platforms/85xx/Makefile<br>Hunk #1 FAILED at=
 3<br>1 out of 1 hunk FAILED -- saving rejects to file arch/powerpc/platfor=
ms/85xx/Makefile.rej<br>patching file arch/powerpc/platforms/85xx/mpc85xx_c=
ds.c
<br>patching file arch/powerpc/platforms/85xx/mpc85xx_cds.h<br>patching fil=
e include/asm-ppc/mpc85xx.h<br>&nbsp;<br>It looks seem the Makefile and Kco=
nfig don't match yours.</div>
<div>&nbsp;</div>
<div>Who have the successful patch experience. Thank you to tell me the rig=
ht procedure!<br>&nbsp;<br>BTW: the patch command version is 2.5.4<br>&nbsp=
;<br>Best Regards</div>
<div>Lu</div>

------=_Part_3609_21271391.1144247543163--
