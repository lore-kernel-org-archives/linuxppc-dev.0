Return-Path: <SRS0=12G2=SE=denx.de=sr@srs.kundenserver.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id BC7ACDDE1F
	for <linuxppc-dev@ozlabs.org>; Tue, 15 Jan 2008 06:43:20 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] MTD for Taco
Date: Mon, 14 Jan 2008 20:42:56 +0100
References: <477F12D1.2070109@pikatech.com>
	<20080114024432.1dcba2f7@vader.jdub.homelinux.org>
	<478B9CB6.7000408@pikatech.com>
In-Reply-To: <478B9CB6.7000408@pikatech.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200801142042.56847.sr@denx.de>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Monday 14 January 2008, Sean MacLennan wrote:
> Josh Boyer wrote:
> > But did you go back and verify the EBC settings were correct on your
> > board?  This shouldn't be needed at all if the EBC bank settings and
> > timings are correct.
> >
> > josh
>
> In the EBC0_CFG register we set the RTC (Ready Timeout Count) to 0 and
> the sequoia uses 7. Also we set the EMS (External Master Size) to none
> and the sequoia sets it to 8 bit.
>
> This is in uboot, the dts are basically the same.

And the EBC0_BxCR & EBC0BxAP registers for the CS where the NAND is connected? 
How are they configured?

Best regards,
Stefan

=====================================================================
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: +49-8142-66989-0 Fax: +49-8142-66989-80  Email: office@denx.de
=====================================================================
