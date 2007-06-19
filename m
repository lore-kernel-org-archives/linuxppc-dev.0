Return-Path: <scottwood@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id D9857DDE29
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 20 Jun 2007 03:57:48 +1000 (EST)
Message-ID: <46781912.1060609@freescale.com>
Date: Tue, 19 Jun 2007 12:57:38 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: b.vigneshkumar@gdatech.co.in
Subject: Re: Regarding SCC in DTS File
References: <4677C9C2.6080802@gdatech.co.in>
In-Reply-To: <4677C9C2.6080802@gdatech.co.in>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-embedded@ozlabs.org, Zhang Wei-r63237 <Wei.Zhang@freescale.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

b.vigneshkumar wrote:
> Hi,
> 
> What does these two lines in DTS File.
> Can u let me know what this suppose to mean
> 
> scc@a00 {
>         ........
>         rx-clock = <1>;
>         tx-clock = <1>;

These indicate which baud rate generator the serial port is attached to.

>                ........
>          interrupts = <1e 3>;
>                interrupt-parent = <&Cpm_pic>;

These indicate that the serial port uses interrupt 0x1e on the CPM PIC.

> Actually where can we get a better documentation for the DTS File? 

Documentation/powerpc/booting-without-of.txt

-Scott
