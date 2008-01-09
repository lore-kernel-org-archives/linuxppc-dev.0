Return-Path: <Jogi95@web.de>
Received: from fmmailgate04.web.de (fmmailgate04.web.de [217.72.192.242])
	by ozlabs.org (Postfix) with ESMTP id F32BEDE177
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 10 Jan 2008 06:00:30 +1100 (EST)
Date: Wed, 09 Jan 2008 20:00:27 +0100
Message-Id: <524369371@web.de>
MIME-Version: 1.0
From: Joachim Meyer <Jogi95@web.de>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Linux for ml310
Content-Type: text/plain; charset=iso-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi

Thanks for your great help!
I added following lines which I found at the old xparameters=5Fml300.h, whic=
h was part of the kernel-sources but was replaced with the one of the BSP:=

--------------------------------------------------------------------------=
--------------------------------------------------------
#define XPAR=5FXUARTNS550=5FCLOCK=5FHZ 100000000
#define XPAR=5FDCR=5FINTC=5F0=5FOPB=5FUART16550=5F0=5FIP2INTC=5FIRPT=5FINTR 6
#define XPAR=5FOPB=5FUART16550=5F0=5FBASEADDR 0xA0000000
#define XPAR=5FUARTNS550=5F0=5FCLOCK=5FFREQ=5FHZ XPAR=5FXUARTNS550=5FCLOCK=5FHZ
#define XPAR=5FINTC=5F0=5FUARTNS550=5F0=5FVEC=5FID XPAR=5FDCR=5FINTC=5F0=5FOPB=5FUART16550=5F0=5FIP2=
INTC=5FIRPT=5FINTR
#define XPAR=5FUARTNS550=5F0=5FBASEADDR (XPAR=5FOPB=5FUART16550=5F0=5FBASEADDR+0x1000)
--------------------------------------------------------------------------=
--------------------------------------------------------
now  the compiling ends successfully.
Thanks again
Joachim
=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F=5F
Jetzt neu! Sch=FCtzen Sie Ihren PC mit McAfee und WEB.DE. 30 Tage
kostenlos testen. http://www.pc-sicherheit.web.de/startseite/=3Fmc=3D022220
