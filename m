Return-Path: <vneethv@gmail.com>
Received: from mail-wg0-x22a.google.com (mail-wg0-x22a.google.com
 [IPv6:2a00:1450:400c:c00::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B67361A0946
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Aug 2014 16:05:48 +1000 (EST)
Received: by mail-wg0-f42.google.com with SMTP id l18so5087824wgh.1
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 07 Aug 2014 23:05:44 -0700 (PDT)
MIME-Version: 1.0
From: Vineeth <vneethv@gmail.com>
Date: Fri, 8 Aug 2014 11:35:24 +0530
Message-ID: <CAFbQSaA80pdzXBk2Om4ewGS9FTWc_tPvu9MM596gPc-_B3igVw@mail.gmail.com>
Subject: T1040QDS warm reboot
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=047d7bfcfc18e92d65050017fe09
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--047d7bfcfc18e92d65050017fe09
Content-Type: text/plain; charset=UTF-8

Was wondering how "reboot" works from linux kernel for t1040qds.

When checked, @arch/powerpc/sysdev/fsl_soc.c
__setup_rstcr, an ioremap is done for the offset 0xb0 and writes 0x2 to
that to reboot the machine. and it works properly.

when checked the reference manual for T1040QDS, it was given that RST_CTL
is at offset 0x40 and the RST is the 7th bit of same.

then how's has-rstcr/reboot works ?

Vineeth

--047d7bfcfc18e92d65050017fe09
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>Was wondering how &quot;reboot&quot; w=
orks from linux kernel for t1040qds.<br><br></div>When checked, @arch/power=
pc/sysdev/fsl_soc.c <br></div>__setup_rstcr, an ioremap is done for the off=
set 0xb0 and writes 0x2 to that to reboot the machine. and it works properl=
y.<br>


<br></div>when checked the reference manual for T1040QDS, it was given that=
 RST_CTL is at offset 0x40 and the RST is the 7th bit of same. <br><br></di=
v><div>then how&#39;s has-rstcr/reboot works ?<br><br></div><div>Vineeth<br=
>

</div><div><br></div><br></div>

--047d7bfcfc18e92d65050017fe09--
