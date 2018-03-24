Return-Path: <sombat3960@gmail.com>
Received: from mail-lf0-x22f.google.com (mail-lf0-x22f.google.com
 [IPv6:2a00:1450:4010:c07::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 407V5F3RFhzF1pS
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Mar 2018 16:55:57 +1100 (AEDT)
Received: by mail-lf0-x22f.google.com with SMTP id e5-v6so21223472lfb.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Mar 2018 22:55:57 -0700 (PDT)
MIME-Version: 1.0
From: Sombat Tragolgosol <sombat3960@gmail.com>
Date: Sat, 24 Mar 2018 12:55:52 +0700
Message-ID: <CAC1vu61+rnPMiJebkCXCjAtnxG27hsc8jPDQ_Xz5x=Vamz6b5g@mail.gmail.com>
Subject: "powerpc_debugfs_root" not exist on linux-4.4.123 for powerpc arch.
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary="00000000000092597e0568223145"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--00000000000092597e0568223145
Content-Type: text/plain; charset="UTF-8"

My system: ps3
OS: Gentoo linux

Today, I've tried to update my Linux kernel jump from 4.4.100 to 4.4.123.
I'm not sure and perhaps this source tree is still active maintenance. If
not I'm really sorry for my disturbance.

Compile source problems:

1) missing "debugfs.h" on arch/powerpc/include/asm path
2) setup-64.c need to be fixed for adding debugfs.h on above path

I find "github.com/torvalds/linux" adding a year ago, but it is still
missing for current linux-4.4.123 source tree.

For another version higher, I don't try yet.

Thanks in advance.

--00000000000092597e0568223145
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>My system: ps3<br>OS: Gentoo linu=
x<br><br>Today, I&#39;ve tried to update my Linux kernel jump from 4.4.100 =
to 4.4.123. <br>I&#39;m not sure and perhaps this source tree is still acti=
ve maintenance. If not I&#39;m really sorry for my disturbance.<br><br></di=
v><div>Compile source problems:<br><br></div>1) missing &quot;debugfs.h&quo=
t; on arch/powerpc/include/asm path<br>2) setup-64.c need to be fixed for a=
dding debugfs.h on above path<br><br></div>I find &quot;<a href=3D"http://g=
ithub.com/torvalds/linux">github.com/torvalds/linux</a>&quot; adding a year=
 ago, but it is still missing for current linux-4.4.123 source tree. <br><b=
r></div>For another version higher, I don&#39;t try yet. <br><br></div>Than=
ks in advance.<br></div><br></div>

--00000000000092597e0568223145--
