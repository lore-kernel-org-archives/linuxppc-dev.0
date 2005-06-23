Return-Path: <scop@digitel.com.br>
Received: from hermes.digitel.com.br (hermes.digitel.com.br [200.198.105.36])
	by ozlabs.org (Postfix) with ESMTP id 1361C67B45
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 24 Jun 2005 04:49:04 +1000 (EST)
Received: from [10.10.10.4] by hermes.digitel.com.br (GMS
	10.03.3304/NU1492.00.9f6ce814) with ESMTP id gvvopbaa for
	linuxppc-embedded@ozlabs.org; Thu, 23 Jun 2005 15:53:32 -0300
Content-Type: text/plain;
  charset="iso-8859-1"
From: Ricardo Scop <scop@digitel.com.br>
To: scarayol@assystembrime.com,
 linuxppc-embedded@ozlabs.org
Date: Thu, 23 Jun 2005 15:53:54 -0300
References: <OFD72AE9CC.023B6AC3-ONC1257029.0030219E@brime.fr>
In-Reply-To: <OFD72AE9CC.023B6AC3-ONC1257029.0030219E@brime.fr>
MIME-Version: 1.0
Message-Id: <200506231553.54283.scop@digitel.com.br>
Subject: Re: Fast Ethernet device driver for MPC885
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Sophie,

On Thursday 23 June 2005 06:09, scarayol@assystembrime.com wrote:
> Hi all.
>
> I use a custom board with a MPC885 microprocessor. I want to test the
> Ethernet chain on my board so i made an external loopback on the Ethern=
et
> port. I want to transmit datas and read the received datas.
>
> Which driver have i to use and which name to open it. I don' see any dr=
iver
> that seems to be the fec one in /dev/.. =20
Well, fec registers as a network device, so you should use the sockets AP=
I to=20
access it.

>I think i have to use the routines
> in pqfec.c instead of fec.c.=20
Don't know about them, sorry.

> But I don't know how the driver works.
> Which kind of driver is it and how access to the routines from user spa=
ce
> in order to do my tests ?
Read above. "man socket" is a good start.

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
