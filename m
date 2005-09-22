Return-Path: <scop@digitel.com.br>
Received: from phoenix.digitel.com.br (unknown [200.198.105.46])
	by ozlabs.org (Postfix) with ESMTP id 37354682F8
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 23 Sep 2005 06:40:54 +1000 (EST)
Received: from [10.10.10.4] by phoenix.digitel.com.br (GMS
	10.03.3304/NU1492.00.9fae9071) with ESMTP id ryxzrbaa for
	linuxppc-embedded@ozlabs.org; Thu, 22 Sep 2005 17:40:03 -0300
Content-Type: text/plain;
  charset="utf-8"
From: Ricardo Scop <scop@digitel.com.br>
To: =?utf-8?q?=E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84EMAIL?= <rober@opnet.com.tw>,
	linuxppc-embedded@ozlabs.org
Date: Thu, 22 Sep 2005 17:47:40 -0300
References: <1127354851.14175.4.camel@banana>
In-Reply-To: <1127354851.14175.4.camel@banana>
MIME-Version: 1.0
Message-Id: <200509221747.41076.scop@digitel.com.br>
Subject: Re: How to limit the log file size?
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Rober,

On Wednesday 21 September 2005 23:07, =E5=BE=90=E5=B0=8F=E5=A8=81=E7=9A=84=
EMAIL wrote:
> Hi all:
>
>     There are some daemon like snmpd, boa...has log file at directory
> var, I want to know how to limte it's file size?

I'm using emlog module (http://www.circlemud.org/~jelson/software/emlog/)=
 to=20
create circular buffers that are used as log files instead of regular one=
s.=20
You can define the file size when it is created; runs smoothly and=20
flawlessly.

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
