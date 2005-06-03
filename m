Return-Path: <scop@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id ECB7F67B26
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  3 Jun 2005 10:09:24 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id uhitobaa for
	linuxppc-embedded@ozlabs.org; Thu, 2 Jun 2005 21:14:29 -0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: Srivatsan CR <Srivatsan.CR@in.flextronics.com>,
	linuxppc-embedded@ozlabs.org
Date: Thu, 2 Jun 2005 21:11:08 -0300
References: <3B58B875DBDE504F94D2A1A1C9DF6F1FD61A69@bglnt005.asia.ad.flextronics.com>
In-Reply-To: <3B58B875DBDE504F94D2A1A1C9DF6F1FD61A69@bglnt005.asia.ad.flextronics.com>
MIME-Version: 1.0
Message-Id: <200506022111.08289.scop@digitel.com.br>
Subject: Re: Newbie question on Linux-PPC
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Srivatsan,

On Thursday 02 June 2005 04:41, Srivatsan CR wrote:
> Hi all,
>
>    Thanks everyone for the time. It's done and I have it working.
>
>    I have another question regarding MAC address in Linux. I had ported
> U-boot onto our customized board (MPC8280 based). It is working fine. I=
 am
> also able to boot a Linux Kernel. The Kernel version is Linux-2.4.20 .
>
> We set the MAC address for the board in U-boot as 00:FD:11:01:01:01. Bu=
t
> when the Linux Kernel boots it takes the MAC as 00:FD:81:01:01:01.
>
> I have confirmed that the U-boot passes the MAC address properly to the
> Linux Kernel properly. Can anyone guide me to where to look out for the
> issue stated above in the Linux code?

Check if there're some hack in fcc_enet.c driver code, regarding the MAC=20
address setup.

HTH,

--=20
Ricardo Scop.

        \|/
    ___ -*-
   (@ @)/|\
  /  V  \|  R SCOP Consult.
 /(     )\  Linux-based communications
--^^---^^+------------------------------
rscop@matrix.com.br
+55 51 999-36-777
Porto Alegre, RS - BRazil
--
P. S.: "If you don't have time to do it right, when will you have time
to do it over?"  -- Penny Hines =20
