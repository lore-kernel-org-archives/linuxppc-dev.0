Date: Mon, 17 Mar 2003 23:26:17 +0900
From: "Q-ha Park" <qhpark@jchyun.com>
To: j.rakesh@gdatech.co.in, kskim@neowave.co.kr
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re:RE: ppc_405-nm
Message-ID: <dz3hnc44/linuxppc-embedded@lists.linuxppc.org/qhpark@jchyun.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=euc-kr
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


yup, 'nm' in your host machine should work on your kernel to generate System.map although 'nm' and 'ppc_405-nm' don't generate the EXACTLY same output.
but it's weird that ppc_405-nm was not installed along with other cross tool-chain.
maybe you want to try to install other 405 preview kits, with luck you can get the whole set of bins you want.



----Original Message----
From: "Kim, Kwansuk" <kskim@neowave.co.kr>
Sent: 03-03-17 (Mon) PM 10:09
To: "Rakesh Jagota" <j.rakesh@gdatech.co.in>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: RE: ppc_405-nm

>
>Why don't you use the 'nm' for your host system?
>
>It will work with any object or elf file on any host system.
>
>(Even big-endian object on little-endian system)
>
> ==============================================
>     Just for fun...
>                                                  - Linus Torvalds
> ==============================================
>  Kwansuk Kim
>  Engineer, NeoWave Inc.
>  Tel   +82-31-380-4927    Fax +82-31-380-4747
>  E-mail: kskim@neowave.co.kr
>==============================================
>
>-----Original Message-----
>From: owner-linuxppc-embedded@lists.linuxppc.org [mailto:owner-linuxppc-
>embedded@lists.linuxppc.org]On Behalf Of Rakesh Jagota
>Sent: Monday, March 17, 2003 5:03 PM
>To: linuxppc-embedded@lists.linuxppc.org
>Subject: ppc_405-nm
>
>
>
>
>Hi all,
>I am working on linux. I am working with custom design board based on
>STBx25xx IBM ppc405 processor. I have downloaded the montavista preview kit
>and install on my system. I am not finding one the option "ppc_405-nm" in my
>cross-compiler bin directory. I want to see the system.map file and
>vmlinux.dis file, which is not possible without this option. Can anyone
>suggest me how can I include this ppc_405-nm option in my bin directory.
>
>Thanks & Regards,
>
>Rakesh
>
>
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
