Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id 8392568704
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 15 Nov 2005 07:13:00 +1100 (EST)
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: hubert loewenguth <hubert.loewenguth@thales-bm.com>,
	linuxppc-embedded@ozlabs.org
Date: Mon, 14 Nov 2005 17:53:52 -0200
References: <4378CAA8.5080808@thales-bm.com>
In-Reply-To: <4378CAA8.5080808@thales-bm.com>
MIME-Version: 1.0
Message-Id: <200511141753.52832.scop@digitel.com.br>
Subject: Re: MPC8260 fcc_enet transmit timed out
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi, Hubert

On Monday 14 November 2005 15:34, hubert loewenguth wrote:
> Hello to the community
>
> After having searched more than a week to correct my problem, I have
> finally decided to try to find some help :
>
> - I have a board with a MPC8260 (HIP 3 C.2), with three PHY chipset :
> LXT971A from intel
> - The MII  lines MDC and MDIO are present, but I have no PHY interrupt =
line
> =3D> so I have to configure my PHY and the fcc_enet.c drivers to be in
> half-duplex mode
> - I use the 2.4.20 linux kernel
                  ^^
                  You could try a newer version, maybe the problem is alr=
eady=20
gone.

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
