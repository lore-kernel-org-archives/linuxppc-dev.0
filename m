Return-Path: <marwahamza63@gmail.com>
Received: from mail-vk0-x241.google.com (mail-vk0-x241.google.com
 [IPv6:2607:f8b0:400c:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rJ9ff0pt8zDqR6
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 19:04:26 +1000 (AEST)
Received: by mail-vk0-x241.google.com with SMTP id a6so926371vkg.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 May 2016 02:04:25 -0700 (PDT)
MIME-Version: 1.0
Date: Mon, 30 May 2016 10:04:22 +0100
Message-ID: <CAGF64GXnJ-qPHo6xoueE5hPmuNFDG+n+oNWr-O1J1kaUD0zyDg@mail.gmail.com>
Subject: running qemu for powerpc (32bits) architecture
From: Marwa Hamza <marwahamza63@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Content-Type: multipart/alternative; boundary=001a114847dadcf42305340b8a1a
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--001a114847dadcf42305340b8a1a
Content-Type: text/plain; charset=UTF-8

hello everyone
I'm trying to run qemu for powerpc architecture but either
*1/* i got a black screen with this sentence " QEMU 2.4.0.1 monitor - type
help for more information"
                       (QEMU)
if i run this command ./ppc-softmmu/qemu-system-ppc -M ppce500 -kernel
../linux-4.4.1/arch/powerpc/boot/zImage -initrd
powerpc/busybox-1.21.0/rootfs.img.gz -append "root=/dev/ram rdinit=/bin/sh"
*2/* or i got this error "rom: requested regions overlap (rom
/home/marwa/Bureau/lauterbach/powerpc/busybox-1.21.0/rootfs.img.gz.
free=0x0000000001878dfc, addr=0x0000000001579000)
rom check and register reset failed " if i run this command
./ppc-softmmu/qemu-system-ppc -M mac99 -kernel
/home/marwa/Bureau/lauterbach/powerpc/linux-4.4.1/arch/powerpc/boot/zImage
-initrd /home/marwa/Bureau/lauterbach/powerpc/busybox-1.21.0/rootfs.img.gz
-append "root=/dev/ram rdinit=/bin/sh"
*3/* or i got this error
qemu-system-ppc: Could not load PowerPC BIOS 'ppc405_rom.bin'
when i run this command
./ppc-softmmu/qemu-system-ppc -M ref405ep -kernel
/home/marwa/Bureau/lauterbach/powerpc/linux-4.4.1/arch/powerpc/boot/zImage
-initrd /home/marwa/Bureau/lauterbach/powerpc/busybox-1.21.0/rootfs.img.gz
-append "root=/dev/ram rdinit=/bin/sh"

and i have tried all machines available for powerpc in qemu but i got
always one of those three result , i could't access to the file system

any suggestion please
regards,
Marwa

--001a114847dadcf42305340b8a1a
Content-Type: text/html; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

<div dir=3D"ltr"><div><div><div><div><div>hello everyone<br></div>I&#39;m t=
rying to run qemu for powerpc architecture but either<br><b>1/</b> i got a =
black screen with this sentence &quot; QEMU 2.4.0.1 monitor - type help for=
 more information&quot;<br></div>=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0 (QEMU)<br></div>if i run this command ./ppc-softmmu/qemu-sy=
stem-ppc -M ppce500 -kernel ../linux-4.4.1/arch/powerpc/boot/zImage -initrd=
 powerpc/busybox-1.21.0/rootfs.img.gz -append &quot;root=3D/dev/ram rdinit=
=3D/bin/sh&quot;<br></div><b>2/</b> or i got this error &quot;rom: requeste=
d regions overlap (rom /home/marwa/Bureau/lauterbach/powerpc/busybox-1.21.0=
/rootfs.img.gz. free=3D0x0000000001878dfc, addr=3D0x0000000001579000)<br>ro=
m check and register reset failed &quot; if i run this command <br>./ppc-so=
ftmmu/qemu-system-ppc -M mac99 -kernel /home/marwa/Bureau/lauterbach/powerp=
c/linux-4.4.1/arch/powerpc/boot/zImage -initrd /home/marwa/Bureau/lauterbac=
h/powerpc/busybox-1.21.0/rootfs.img.gz -append &quot;root=3D/dev/ram rdinit=
=3D/bin/sh&quot;<br></div><b>3/</b> or i got this error <br><div>qemu-syste=
m-ppc: Could not load PowerPC BIOS &#39;ppc405_rom.bin&#39;<br></div><div>w=
hen i run this command <br>./ppc-softmmu/qemu-system-ppc -M ref405ep -kerne=
l /home/marwa/Bureau/lauterbach/powerpc/linux-4.4.1/arch/powerpc/boot/zImag=
e -initrd /home/marwa/Bureau/lauterbach/powerpc/busybox-1.21.0/rootfs.img.g=
z -append &quot;root=3D/dev/ram rdinit=3D/bin/sh&quot;<br><br></div><div>an=
d
 i have tried all machines available for powerpc in qemu but i got=20
always one of those three result , i could&#39;t access to the file system<=
br><br></div><div>any suggestion please<br></div><div>regards,<br></div>Mar=
wa</div>

--001a114847dadcf42305340b8a1a--
