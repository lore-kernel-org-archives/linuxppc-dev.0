Return-Path: <marwahamza63@gmail.com>
Received: from mail-vk0-x242.google.com (mail-vk0-x242.google.com
 [IPv6:2607:f8b0:400c:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qw5Q121M3zDq5s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Apr 2016 02:43:53 +1000 (AEST)
Received: by mail-vk0-x242.google.com with SMTP id u23so94646vkb.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 27 Apr 2016 09:43:53 -0700 (PDT)
MIME-Version: 1.0
Date: Wed, 27 Apr 2016 17:43:49 +0100
Message-ID: <CAGF64GWNqfiWH6Joq0C7sCwQkuM2X-D6Ce-xM+iQGXPoaYYxnQ@mail.gmail.com>
Subject: error while trying to compile linux kernel with powerpc arch
From: Marwa Hamza <marwahamza63@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a114e29483a39bc05317a1d14
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114e29483a39bc05317a1d14
Content-Type: text/plain; charset=UTF-8

hello
every time i try to compile the linux kernel with arch=powerpc i got this
error

WRAP arch / powerpc / boot / zImage.pseries
powerpc-linux-gnu-ld: unrecognized emulation mode: -T
Emulations supported: elf32ppclinux elf32ppc elf32ppcsim elf64ppc elf32_spu
make [1]: *** [arch / powerpc / boot / zImage.pseries] Error 1
make: *** [zImage] Error 2

im using powerpc-linux-gnu ( sudo apt-get install powerpc-linux-gnu)  and
linux-4.4.1
make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-  pseries_defconfig
make ARCH=powerpc CROSS_COMPILE=powerpc-linux-gnu-
ubuntu 14.04
any suggestion ?

--001a114e29483a39bc05317a1d14
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div>hello<br>every time i try to compile t=
he linux kernel with arch=3Dpowerpc i got this error <br><br><span id=3D"re=
sult_box" class=3D"" lang=3D"en"><span class=3D"">WRAP</span> <span>arch /<=
/span> <span class=3D"">powerpc</span> <span>/ boot /</span> <span class=3D=
"">zImage.pseries</span><br><span>powerpc</span><span class=3D"">-linux-</s=
pan><span class=3D"">gnu-</span><span class=3D"">ld</span><span class=3D"">=
:</span> <span class=3D"">unrecognized</span> <span>emulation mode</span><s=
pan>:</span> <span>-T</span><br><span class=3D"">Emulations</span> <span>su=
pported:</span> <span>elf32ppclinux</span> <span>elf32ppc</span> <span>elf3=
2ppcsim</span> <span>elf64ppc</span> <span>elf32_spu</span><br><span>make [=
</span><span class=3D"">1]</span><span class=3D"">: ***</span> <span>[arch<=
/span> <span>/ powerpc</span> <span>/ boot /</span> <span>zImage.pseries</s=
pan><span>]</span> <span>Error 1</span><br><span class=3D"">make: ***</span=
> <span>[</span><span>zImage</span><span>]</span> <span>Error 2</span></spa=
n><br><br></div>im using powerpc-linux-gnu ( sudo apt-get install powerpc-l=
inux-gnu)=C2=A0 and linux-4.4.1 <br></div>make ARCH=3Dpowerpc CROSS_COMPILE=
=3Dpowerpc-linux-gnu-=C2=A0 pseries_defconfig<br>make ARCH=3Dpowerpc CROSS_=
COMPILE=3Dpowerpc-linux-gnu-<br></div>ubuntu 14.04<br></div>any suggestion =
?<br></div>

--001a114e29483a39bc05317a1d14--
