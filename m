Return-Path: <scop@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id DEE38679FF
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 10 May 2005 05:04:25 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	9.01.3158/NU1492.00.9f6ce814) with ESMTP id zsilnbaa for
	linuxppc-embedded@ozlabs.org; Mon, 9 May 2005 16:08:22 -0200
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Date: Mon, 9 May 2005 16:05:07 -0300
References: <427F4D3B.6060403@intracom.gr>
In-Reply-To: <427F4D3B.6060403@intracom.gr>
MIME-Version: 1.0
Message-Id: <200505091605.08630.scop@digitel.com.br>
Subject: Re: [PATCH  02/04] Freescale Ethernet combined driver
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Pantelis,

On Monday 09 May 2005 08:44, Pantelis Antoniou wrote:
> Hi
>
> The following patch is a combined FCC/FEC ethernet driver
> for the Freescale line of PowerQUICCs.
>
> FECs on 8xx and FCCs on 82xx are supported.
>
> This part of the patch contains the core driver.
>
and, inside the patch:

+#if LINUX_VERSION_CODE < KERNEL_VERSION(2,5,0)

Does this mean that the code is designed to be backwards compatible to 2.=
4.x=20
kernel code? If so, I could give it a try and, maybe, even make sure that=
 it=20
keeps such compatibility.

Best regards,

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
