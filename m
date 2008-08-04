Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 89CBCDDEF3
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  4 Aug 2008 23:41:07 +1000 (EST)
Message-ID: <4897076A.9020102@coritel.it>
Date: Mon, 04 Aug 2008 15:43:06 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: Fabien Oriede <fabien.oriede@yahoo.fr>
Subject: Re: suffisant space for U-Boot, Linux and an initrd image ? (4MB
	SDRAM)
References: <789365.58211.qm@web27401.mail.ukl.yahoo.com>
In-Reply-To: <789365.58211.qm@web27401.mail.ukl.yahoo.com>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
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

Fabien Oriede ha scritto:
> Hi all,
> I would like to know if this is possible to port U-Boot, Linux and an initrd image on a board with 4MB of SDRAM ?
> When Linux try to boot, there is this line on the terminal :
> "Memory : 2036k available (1036k kernel code, 256k data, 80k init, 0k highmem)"
> So I have 2036k memory available for my initrd image but I don't know if this is suffisant.
> Thanks in advance.
> Regards,
> Fabien.
> 
> 
>       _____________________________________________________________________________ 
> Envoyez avec Yahoo! Mail. Une boite mail plus intelligente http://mail.yahoo.fr
> 
> 
> ------------------------------------------------------------------------
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded

Only 4MB of sdram? As far as I know the smallest device with Linux is 
picotux with 8MB of ram and 2MB of flash.

-- 
Marco Stornelli
Embedded Software Engineer
CoRiTeL - Consorzio di Ricerca sulle Telecomunicazioni
http://www.coritel.it

marco.stornelli@coritel.it
+39 06 72582838
