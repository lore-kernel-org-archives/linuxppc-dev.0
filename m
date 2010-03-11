Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 01B85B7D03
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Mar 2010 16:20:39 +1100 (EST)
Subject: Re: PowerPC 85xx board are caused die by Commit:
	864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc: Use
	lwarx/ldarx hint in bit locks)
Mime-Version: 1.0 (Apple Message framework v1077)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <54d399751003101920j598de9fdkd7c8617c8e4fa191@mail.gmail.com>
Date: Wed, 10 Mar 2010 23:20:30 -0600
Message-Id: <BCD4C354-E29A-4514-BB04-CFE92BFBC28A@kernel.crashing.org>
References: <54d399751003101920j598de9fdkd7c8617c8e4fa191@mail.gmail.com>
To: Andrew Liu <andrew.liu200917@gmail.com>
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Mar 10, 2010, at 9:20 PM, Andrew Liu wrote:

> Hi Guys:
> I have done several experiments on  fsl_8548cds and fsl_p2020rdb, =
pinpointed the commit: 864b9e6fd76489aab422bac62162f57c52e06ed8(powerpc: =
Use lwarx/ldarx hint in bit locks)  cause the bootup stalledd.
>=20
> "
> Filename 'fsl_8548cds/uImage'.
> Load address: 0x1000000
> Loading: =
#################################################################
>      #######################################
> done
> Bytes transferred =3D 1526546 (174b12 hex)
> Speed: 100, full duplex
> Using eTSEC0 device
> Filename 'sliu/fsl_8548cds/mpc8548cds.dtb'.
> Load address: 0xc00000
> Loading: #
> done
> Bytes transferred =3D 9993 (2709 hex)
> ## Booting image at 01000000 ...
>    Image Name:   Linux-2.6.34-rc1-00005-g522dba7
>    Image Type:   PowerPC Linux Kernel Image (gzip compressed)
>    Data Size:    1526482 Bytes =3D  1.5 MB
>    Load Address: 00000000
>    Entry Point:  00000000
>    Verifying Checksum ... OK
>    Uncompressing Kernel Image ... OK
>    Booting using the fdt at 0xc00000
>    Loading Device Tree to 007fb000, end 007fd708 ... OK
> "
> =20
> I guess all 85xx or booke board has this issue.

that's very odd since __PPC_EH should be ignored on PPC32 and thus 85xx.

- k=
