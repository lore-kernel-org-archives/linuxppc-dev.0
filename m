Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id EC9F9DDDF0
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 24 Nov 2008 19:12:28 +1100 (EST)
Message-ID: <492A5D7A.7070907@coritel.it>
Date: Mon, 24 Nov 2008 08:53:30 +0100
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Thomas Johnson <TMJohnson@fyldemicro.com>
Subject: Re: SRAM
References: <02296E583CC11C4D9365985B761F1DDE73613B@www.fyldemicro.co.uk>
In-Reply-To: <02296E583CC11C4D9365985B761F1DDE73613B@www.fyldemicro.co.uk>
Content-Type: text/plain; charset=ISO-8859-15
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

If it's a "persistent" SRAM with a battery, try look at it:

http://pramfs.sourceforge.net

Regards,

Marco

Thomas Johnson ha scritto:
> We have a new PPC based board which includes some SRAM (actually
> Everspin MRAM).
>  
> I can't work out the best way to mount this device or what filing system
> to run on it, any advice ?
>  
> Thanks 
>  
> TJ
> 
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
