Return-Path: <scop@digitel.com.br>
Received: from cosmos.digitel.com.br (cosmos.digitel.com.br [200.198.105.42])
	by ozlabs.org (Postfix) with ESMTP id E3009DDDE4
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  7 Nov 2007 08:57:27 +1100 (EST)
From: Ricardo Scop <scop@digitel.com.br>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Problem replacing a Samsung K9F1208U0M NAND flash chip with ST
	NAND512W3A
Date: Tue, 6 Nov 2007 19:20:11 -0200
References: <964605.98294.qm@web53605.mail.re2.yahoo.com>
In-Reply-To: <964605.98294.qm@web53605.mail.re2.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200711061920.11491.scop@digitel.com.br>
Cc: Santanu Sen <sensantanu_82@yahoo.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Santanu,

On Sunday 04 November 2007 12:34, Santanu Sen wrote:
> Facing some trouble replacing a SAMSUNG K9F1208U0M
> with an ST NAND512W3A. I know it is criminal, but we
> are still using the 2.4 kernel. The excuse is, it is
> impossible to port all our code/drivers to 2.6 within
> the project deadline.
I know the feeling...

>
>
> Here is the story. We could successfully install JFFS2
> on a Samsung  K9F1208U0M NAND chip mounted on a board
> running linux-2.4.20 on a ppc852 processor. 
Hmmm, I would go for the newest 2.4.x kernel release from kernel.org. JFFS2 
support there is reportedly more stable, AFAIK.

Anyway, these are just my 2 cents.

HTH,

-- 
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
