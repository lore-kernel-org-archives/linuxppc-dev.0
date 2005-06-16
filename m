Return-Path: <scop@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id CFA2167B1E
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 17 Jun 2005 07:56:05 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	10.03.3304/NU1492.00.9f6ce814) with ESMTP id baojpbaa for
	linuxppc-embedded@ozlabs.org; Thu, 16 Jun 2005 19:00:12 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: eagle keeper <palazzinaro@gmail.com>,
 linuxppc-embedded@ozlabs.org
Date: Thu, 16 Jun 2005 18:59:05 -0300
References: <74499824050616065835741324@mail.gmail.com>
In-Reply-To: <74499824050616065835741324@mail.gmail.com>
MIME-Version: 1.0
Message-Id: <200506161859.05418.scop@digitel.com.br>
Subject: Re: [newbie]: mpc8260 kernel opps sig 7 and 11 please help!
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi eagle ;)

On Thursday 16 June 2005 10:58, eagle keeper wrote:
> Hi all,
> since i'm hanged with this problem since 2 weeks ago... and i can't
> solve it, i wonder if anyone
> of you have any idea to suggest me.
> I'm working on an mpc8260 and used ELDK to develop u-boot and kernel.
> Actually I'm using ads8260_defoconfig configuration file to make the
> kernel image.
Are you sure your board is a 100% hw compatible with ADS8260? Particularl=
y in=20
the CPM and peripherals configuration session in the kernel compilation=20
parameters?

You should check this and make the proper modifications in .config.

HTH,

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
