Return-Path: <andrew.liu200917@gmail.com>
Received: from mail-gw0-f42.google.com (mail-gw0-f42.google.com [74.125.83.42])
	by ozlabs.org (Postfix) with ESMTP id 6FEE1B7D23
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 14:20:58 +1100 (EST)
Received: by gwj20 with SMTP id 20so4543920gwj.15
	for <linuxppc-dev@ozlabs.org>; Wed, 10 Mar 2010 19:20:56 -0800 (PST)
MIME-Version: 1.0
Date: Thu, 11 Mar 2010 11:20:52 +0800
Message-ID: <54d399751003101920j598de9fdkd7c8617c8e4fa191@mail.gmail.com>
Subject: PowerPC 85xx board are caused die by Commit:
	864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc:
	Use lwarx/ldarx hint in bit locks)
From: Andrew Liu <andrew.liu200917@gmail.com>
To: Anton Blanchard <anton@samba.org>
Content-Type: multipart/alternative; boundary=0016e6d26594f51edc04817de6be
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

--0016e6d26594f51edc04817de6be
Content-Type: text/plain; charset=ISO-8859-1

Hi Guys:
I have done several experiments on  fsl_8548cds and fsl_p2020rdb, pinpointed
the commit: 864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc: Use
lwarx/ldarx hint in bit locks)  cause the bootup stalledd.

"
Filename 'fsl_8548cds/uImage'.
Load address: 0x1000000
Loading: #################################################################
     #######################################
done
Bytes transferred = 1526546 (174b12 hex)
Speed: 100, full duplex
Using eTSEC0 device
Filename 'sliu/fsl_8548cds/mpc8548cds.dtb'.
Load address: 0xc00000
Loading: #
done
Bytes transferred = 9993 (2709 hex)
## Booting image at 01000000 ...
   Image Name:   Linux-2.6.34-rc1-00005-g522dba7
   Image Type:   PowerPC Linux Kernel Image (gzip compressed)
   Data Size:    1526482 Bytes =  1.5 MB
   Load Address: 00000000
   Entry Point:  00000000
   Verifying Checksum ... OK
   Uncompressing Kernel Image ... OK
   Booting using the fdt at 0xc00000
   Loading Device Tree to 007fb000, end 007fd708 ... OK
"

I guess all 85xx or booke board has this issue.

Thanks
Andrew

--0016e6d26594f51edc04817de6be
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Guys:<br>I have done several experiments on=A0 fsl_8548cds and fsl_p2020=
rdb, pinpointed the commit: 864b9e6fd76489aab422bac62162f57c52e06ed8(powerp=
c: Use lwarx/ldarx hint in bit locks)=A0 cause the bootup stalledd.<br><br>=
&quot;<br>
Filename &#39;fsl_8548cds/uImage&#39;.<br>Load address: 0x1000000<br>Loadin=
g: #################################################################<br>=A0=
=A0=A0 =A0#######################################<br>done<br>Bytes transfer=
red =3D 1526546 (174b12 hex)<br>
Speed: 100, full duplex<br>Using eTSEC0 device<br>Filename &#39;sliu/fsl_85=
48cds/mpc8548cds.dtb&#39;.<br>Load address: 0xc00000<br>Loading: #<br>done<=
br>Bytes transferred =3D 9993 (2709 hex)<br>## Booting image at 01000000 ..=
.<br>
=A0=A0 Image Name:=A0=A0 Linux-2.6.34-rc1-00005-g522dba7<br>=A0=A0 Image Ty=
pe:=A0=A0 PowerPC Linux Kernel Image (gzip compressed)<br>=A0=A0 Data Size:=
=A0=A0=A0 1526482 Bytes =3D=A0 1.5 MB<br>=A0=A0 Load Address: 00000000<br>=
=A0=A0 Entry Point:=A0 00000000<br>=A0=A0 Verifying Checksum ... OK<br>
=A0=A0 Uncompressing Kernel Image ... OK<br>=A0=A0 Booting using the fdt at=
 0xc00000<br>=A0=A0 Loading Device Tree to 007fb000, end 007fd708 ... OK<br=
>&quot;<br>=A0<br>I guess all 85xx or booke board has this issue.<br><br>Th=
anks<br>Andrew<br>

--0016e6d26594f51edc04817de6be--
