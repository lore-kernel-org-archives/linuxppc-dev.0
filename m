Return-Path: <Murray.Jensen@csiro.au>
Received: from vic-ironport-ext-out2.csiro.au (vic-ironport-ext-out2.csiro.au
	[150.229.64.38]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "*.csiro.au",
	Issuer "Comodo Class 3 Security Services CA" (not verified))
	by ozlabs.org (Postfix) with ESMTP id 3E5A267B99
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  1 Jul 2005 03:07:30 +1000 (EST)
From: Murray.Jensen@csiro.au
To: Clemens Koller <clemens.koller@anagramm.de>
In-reply-to: Your message of "Thu, 30 Jun 2005 17:56:30 +0200"
	<42C4162E.4030602@anagramm.de>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 01 Jul 2005 02:57:46 +1000
Message-ID: <931.1120150666@gerd>
Sender: Murray.Jensen@csiro.au
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC85xx DMA support for Kernel 2.6? 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 30 Jun 2005 17:56:30 +0200, Clemens Koller writes:
>But is there any code available for recycling?

Jason McMullan has some code for mpc85xx dma here:

	http://www.evillabs.net/~gus/patches/mpc85xx_dma.patch

Looks like it wouldn't take much to get it working. Cheers!
								Murray...
--
Murray Jensen, CSIRO Manufacturing & Infra. Tech.      Phone: +61 3 9662 7763
Locked Bag No. 9, Preston, Vic, 3072, Australia.         Fax: +61 3 9662 7853
Internet: Murray.Jensen@csiro.au

To the extent permitted by law, CSIRO does not represent, warrant and/or
guarantee that the integrity of this communication has been maintained or
that the communication is free of errors, virus, interception or interference.

The information contained in this e-mail may be confidential or privileged.
Any unauthorised use or disclosure is prohibited. If you have received this
e-mail in error, please delete it immediately and notify Murray Jensen on
+61 3 9662 7763. Thank you.
