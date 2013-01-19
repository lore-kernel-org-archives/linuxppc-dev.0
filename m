Return-Path: <lrakesh05@gmail.com>
Received: from mail-ie0-f171.google.com (mail-ie0-f171.google.com
 [209.85.223.171])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B354D2C007B
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2013 21:47:39 +1100 (EST)
Received: by mail-ie0-f171.google.com with SMTP id 9so3644512iec.2
 for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2013 02:47:37 -0800 (PST)
MIME-Version: 1.0
Date: Sat, 19 Jan 2013 16:11:48 +0530
Message-ID: <CAMROFi2mJ1B=xpLGNkiVsSuRJ62LoDAVUSQ3rWyZck2=6r8apw@mail.gmail.com>
Subject: ml510 booting problem.
From: rakesh l <lrakesh05@gmail.com>
To: linuxppc-dev@ozlabs.org
Content-Type: multipart/alternative; boundary=90e6ba1efd6209bec504d3a1e08f
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--90e6ba1efd6209bec504d3a1e08f
Content-Type: text/plain; charset=ISO-8859-1

Hello All,

              I am trying to port 3.6 linux kernel on ml510 board and i
have already ported 3.6 kernel on ml403 board but i am unable to do the
same thing on ml510. I really don't know what i am missing here.

Tools used :

1) xilinx 13.1 edk
 2) linux kernel from git.xilinx.com (downloaded 3.6 kernel)
 3) eldk 5.3 (cross compilers tools)

Flow go's like this :

1) I have added necessary peripherals in the edk and generated bit stream
and exported it to sdk. In sdk i have creted a .dts file.
 2) The obtained dts file i have placed in arch/powerpc/boot/dts folder
 3) i also got ramdisk image from wiki.xilinx.com/powerpc-linux. (placed in
/arch/powerpc/boot)

compiled kernel using default configuration. i have also enabled soft fpu's

After compiling i got .elf file in arch/powerpc/boot . i took that elf and
download.bit in edk project and clubbed it in xmd console inorder to get
.ace file .
obtained .ace file is loaded in CF and trying to port through rs232, but i
am seeing nothing on the console. what to do.... what i am missing here. I
am breaking my head from past 1 month. Please do reply.

With Regards,
Rakesh.

--90e6ba1efd6209bec504d3a1e08f
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello All,<div><br></div><div>=A0 =A0 =A0 =A0 =A0 =A0 =A0 I am trying to po=
rt 3.6 linux kernel on ml510 board and i have already ported 3.6 kernel on =
ml403 board but i am unable to do the same thing on ml510. I really don&#39=
;t know what i am missing here.</div>
<div><br></div><div>Tools used :</div><div><br></div><div>1) xilinx 13.1 ed=
k</div><div>=A02) linux kernel from <a href=3D"http://git.xilinx.com">git.x=
ilinx.com</a> (downloaded 3.6 kernel)</div><div>=A03) eldk 5.3 (cross compi=
lers tools)</div>
<div><br></div><div>Flow go&#39;s like this :</div><div><br></div><div>1) I=
 have added necessary peripherals in the edk and generated bit stream and e=
xported it to sdk. In sdk i have creted a .dts file.</div><div>=A02) The ob=
tained dts file i have placed in arch/powerpc/boot/dts folder</div>
<div>=A03) i also got ramdisk image from <a href=3D"http://wiki.xilinx.com/=
powerpc-linux">wiki.xilinx.com/powerpc-linux</a>. (placed in /arch/powerpc/=
boot)</div><div><br></div><div>compiled kernel using default configuration.=
 i have also enabled soft fpu&#39;s</div>
<div><br></div><div>After compiling i got .elf file in arch/powerpc/boot . =
i took that elf and download.bit in edk project and=A0clubbed=A0it in xmd c=
onsole inorder to get .ace file .=A0</div><div>obtained .ace file is loaded=
 in CF and trying to port through rs232, but i am seeing nothing on the con=
sole. what to do.... what i am missing here. I am breaking my head from pas=
t 1 month. Please do reply.</div>
<div><br></div><div>With Regards,</div><div>Rakesh.</div>

--90e6ba1efd6209bec504d3a1e08f--
