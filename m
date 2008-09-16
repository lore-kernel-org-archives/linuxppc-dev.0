Return-Path: <marco.stornelli@coritel.it>
Received: from nausicaa2.coritel.it
	(host254-130-static.190-82-b.business.telecomitalia.it
	[82.190.130.254]) by ozlabs.org (Postfix) with ESMTP id 1555CDE09E
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 16 Sep 2008 22:07:22 +1000 (EST)
Message-ID: <48CFA1DC.9030400@coritel.it>
Date: Tue, 16 Sep 2008 14:09:00 +0200
From: Marco Stornelli <marco.stornelli@coritel.it>
MIME-Version: 1.0
To: VenkataKrishna <venkatakrishnap@vrindatech.com>
Subject: Re: module compilation linux
References: <20080916114538.00E65DDDEC@ozlabs.org>
In-Reply-To: <20080916114538.00E65DDDEC@ozlabs.org>
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

Try ARCH=powerpc (lowercase).

Regards.

VenkataKrishna ha scritto:
>  
> 
> I compiled modules in ELDK 4.0 installed in Linux. I got the  configure
> error in show in the below. How to solve that. What are configure values
> should need compile MPC8260 freescale device driver in linux.
> 
>  
> 
> [root@VenkaKrisha linux-2.6-denx]# make ARCH=PowerPC CROSS_COMPILE=ppc_82xx-
> modules
> 
> :0: error: -m64 not supported in this configuration
> 
> :0: error: -m64 not supported in this configuration
> 
> /opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line 31: printf: #:
> invalid number/opt/eldk/usr/src/linux-2.6-denx/scripts/gcc-version.sh: line
> 31: printf: #: invalid number/bin/sh: line 1: [: too many arguments
> 
> scripts/kconfig/conf -s arch/powerpc/Kconfig
> 
> *
> 
> * Restart config...
> 
> *
> 
> *
> 
> * Linux Kernel Configuration
> 
> *
> 
> 64-bit kernel (PPC64) [N/y/?] (NEW)
> 
>  
> 
>  
> 
> With Regards
> 
>  
> 
> Venkatakrishna Pari
> 
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
