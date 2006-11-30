Return-Path: <christophe.alayrac@cresitt.com>
Received: from smtp8-g19.free.fr (smtp8-g19.free.fr [212.27.42.65])
	by ozlabs.org (Postfix) with ESMTP id 94B4167BE7
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Dec 2006 04:14:45 +1100 (EST)
From: "alayrac" <christophe.alayrac@cresitt.com>
To: "'Ming Liu'" <eemingliu@hotmail.com>,
	<mgalassi@c-cor.com>
Subject: RE : Some questions about the Xilinx Temac driver.
Date: Thu, 30 Nov 2006 18:14:43 +0100
Message-ID: <000b01c714a3$07330f40$c900a8c0@CRESITTLAB>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
In-Reply-To: <BAY110-F40D23F776DA18A9693D6EBB2DB0@phx.gbl>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Ming

You will find informations to build linux 2.6 BSP in the file
EDK_8.2\sw\ThirdParty\bsp\linux_2_6_v1_00_a\doc\linux_2_6_v1_00_a.pdf=20

This file is installed with plateform Studio

Regards

Chris

CRESITT INDUSTRIE
12 Rue de Blois, BP6744
45067 ORLEANS Cedex 2
Tel : 02.38.49.45.59
Fax :02.38.49.45.55
Email : christophe.alayrac@cresitt.com=20
Web : http://www.cresitt.com


<----> -----Message d'origine-----
<----> De : linuxppc-embedded-
<----> bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org =
[mailto:linuxppc-
<----> embedded-bounces+christophe.alayrac=3Dcresitt.com@ozlabs.org] De =
la
<----> part de Ming Liu
<----> Envoy=C3=A9 : jeudi 30 novembre 2006 17:37
<----> =C3=80 : mgalassi@c-cor.com
<----> Cc : linuxppc-embedded@ozlabs.org
<----> Objet : Re: Some questions about the Xilinx Temac driver.
<---->=20
<----> Dear Michael,
<----> Now I update my Xilinx design software from 8.1 to 8.2 and notice
<----> that
<----> there is already linux_2_6 support. Then I generated the BSP for
<----> linux 2.6.
<----> I found that there are some differences from the older version, =
e.g.
<----> there
<----> are some files such as XMakefile, xps_connected.cud, etc. I am
<----> confused
<----> with this. So could you please give me a hand on how to use such =
a
<----> generated BSP to build my linux 2.6 kernel? I cannot find any
<----> guidance on
<----> how to do that. Thanks for your help.
<---->=20
<----> BR
<----> Ming
<---->=20
<---->=20
<----> >From: Michael Galassi <mgalassi@c-cor.com>
<----> >Reply-To: Michael Galassi <mgalassi@c-cor.com>
<----> >To: "Ming Liu" <eemingliu@hotmail.com>
<----> >CC: akonovalov@ru.mvista.com, linuxppc-embedded@ozlabs.org
<----> >Subject: Re: Some questions about the Xilinx Temac driver.
<----> >Date: Wed, 29 Nov 2006 08:38:37 -0800
<----> >
<----> >If you use the latest xilinx ISE/EDK/IP update and let it =
overlay
<----> your
<----> >mvl source tree with it's files it shouldn't take you more than =
a
<----> few
<----> >hours to patch things up to where you can compile a kernel which
<----> will
<----> >work on the 3.00b IP.  The PHY support is useless but you can =
work
<----> >around that easily enough.  I've not tried to get any of that
<----> working
<----> >with a semi-current kernel so if you're not using mvl's flavor =
of
<----> 2.6.10
<----> >you may run into other issues.
<----> >
<----> >-michael
<----> >
<----> > >Dear Andrei,
<----> > >I have some questions about your xilinx Temac driver. If =
possible,
<----> please
<----> > >give me a hand on such confusing problems.
<----> > >
<----> > >1. I am using the driver from
<----> > >http://source.mvista.com/~ank/paulus-powerpc/20060309/, and =
the IP
<----> cores
<----> of
<----> > >plb_temac and hard_temac whose hardware versions are 2.00a and
<----> 1.00a
<----> > >specifically. I know the newest versions of those hardwares =
are
<----> 3.00a
<----> and
<----> > >3.00a. Is your driver support the 3.00a version hardware? =
Also, is
<----> the
<----> > >driver from =
http://source.mvista.com/~ank/paulus-powerpc/20060309/
<----> the
<----> > >latest one for Xilinx Temac? If you have some updated version,
<----> please
<----> tell
<----> > >me the address.
<----> > >
<----> > >2. Is that driver from the above address able to support =
SGDMA? In
<----> fact,
<----> I
<----> > >am testing the throughput of the Temac enet by my own little
<----> program
<----> which
<----> > >is very simple. In the program running on the board, the =
pseudo
<----> code
<----> looks
<----> > >just like this:
<----> > >     for(;;){
<----> > >           select();
<----> > >           if(FD_ISSET()){
<----> > >                 recvfrom();
<----> > >           }
<----> > >
<----> > >           sendto();
<----> > >     }
<----> > >
<----> > >The program is just to receive packets from a pc and then =
transfer
<----> them
<----> > >back. But in this condition, the embedded PowerPC CPU is =
easily
<----> used by
<----> > >100&. So I suspect that maybe the DMA is not running properly.
<----> Could you
<----> > >please say something about the DMA in your driver?
<----> > >
<----> > >Thanks a lot for your telling.
<----> > >
<----> > >Regards
<----> > >Ming
<----> > >
<----> > =
>_________________________________________________________________
<----> > >=E5=85=8D=E8=B4=B9=E4=B8=8B=E8=BD=BD MSN Explorer:   =
http://explorer.msn.com/lccn/
<----> > >
<----> > >
<----> > =
>--=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D1695844909=3D=3D
<----> > >Content-Type: text/plain; charset=3D"us-ascii"
<----> > >MIME-Version: 1.0
<----> > >Content-Transfer-Encoding: 7bit
<----> > >Content-Disposition: inline
<----> > >
<----> > >_______________________________________________
<----> > >Linuxppc-embedded mailing list
<----> > >Linuxppc-embedded@ozlabs.org
<----> > >https://ozlabs.org/mailman/listinfo/linuxppc-embedded
<----> > =
>--=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D1695844909=3D=3D--
<---->=20
<----> _________________________________________________________________
<----> =
=E4=B8=8E=E8=81=94=E6=9C=BA=E7=9A=84=E6=9C=8B=E5=8F=8B=E8=BF=9B=E8=A1=8C=E4=
=BA=A4=E6=B5=81=EF=BC=8C=E8=AF=B7=E4=BD=BF=E7=94=A8 MSN Messenger:  =
http://messenger.msn.com/cn
