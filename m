Return-Path: <scop@digitel.com.br>
Received: from phoenix.digitel.com.br (unknown [200.198.105.46])
	by ozlabs.org (Postfix) with ESMTP id 20EBB67ED3
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  5 Aug 2005 05:59:33 +1000 (EST)
Received: from [10.10.10.4] by phoenix.digitel.com.br (GMS
	10.03.3304/NU1492.00.9fae9071) with ESMTP id bowoqbaa for
	linuxppc-embedded@ozlabs.org; Thu, 4 Aug 2005 16:59:17 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: "vikrant.basotra" <vikrant.basotra@indiatimes.com>,
	<linuxppc-embedded@ozlabs.org>
Date: Thu, 4 Aug 2005 17:09:08 -0300
References: <200508041026.PAA00892@WS0005.indiatimes.com>
In-Reply-To: <200508041026.PAA00892@WS0005.indiatimes.com>
MIME-Version: 1.0
Message-Id: <200508041709.09206.scop@digitel.com.br>
Cc: vikrant_basotra@satyam.com
Subject: Re: Linux Porting ISSUE
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Vikrant,

On Thursday 04 August 2005 07:38, vikrant.basotra wrote:
> Hi All,
> =09I am porting Linux on the custom board PMC8266 (having MPC8266
> microprocessor) based on the ADS8266 board. I am using ELDK1.1.1 and
> Linux2.4.24.
> After executing the make xconfig, while saving the settings a message i=
s
> displayed: End of Linux kernel configuration. Check the top level make =
file
> for additional configuration. Next, you must run make dep

This is perfectly normal. Simply run "make dep" as indicated. And, _pleas=
e_,=20
RTFM about linux kernel compilation.

> Now where does this top level make file is.=20
Exactly were it should be, the top level directory.

> I didn't find any other Make
> file higher in the hierarchy.=20
Probably because there is no higher level in the hierarchy? ;)

> Do I need to create that particular make
> file.=20
No.

> What extra setting there would be in that make file.
Probably none.

Have fun!

-Scop.

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
