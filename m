Return-Path: <jsteve17@yahoo.com>
Received: from web33413.mail.mud.yahoo.com (web33413.mail.mud.yahoo.com
	[68.142.206.145]) by ozlabs.org (Postfix) with SMTP id 1D03E68302
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 12 Oct 2005 05:51:19 +1000 (EST)
Message-ID: <20051011195118.26463.qmail@web33413.mail.mud.yahoo.com>
Date: Tue, 11 Oct 2005 12:51:18 -0700 (PDT)
From: Jeff Stevens <jsteve17@yahoo.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Subject: Compilation Error
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

I am trying to cross compile one of our drivers at
work to run on both an AMCC 440SP platform (Luan2),
and an MPC8540 platform (MPC8540ADS).  I am using the
ELDK compilers (ppc_4xx-gcc and ppc_85xx-gcc), and the
kernel.org 2.6.13 source.  I was getting warnings
about implicit declarations for both dma_cache_wback
and dma_cache_inv.  I went ahead and replaced them
with clean_dcache_range and invalidate_dcache_range
(since that is what they are #defined to), and
included cache.h.  So then I was able to get through
the compilation without the implicit declaration
warnings, but now when it does MODPOST, I get warnings
about clean_dcache_range and invalidate_dcache_range
being undefined!  This driver was originally written
for x86 platforms where dma_cache_wback and
dma_cache_inv both are #defined to inline funtions
within io.h.  Has anyone else seen this?  I'm sure
it's most likely an include issue, but I'm not sure
what else to include.  I have tried dma-mapping.h and
cache.h?  Any help would be greatly appreciated. 
Also, if this is the wrong place for this post, what
is the correct place for this question?

Thanks,
   Jeff Stevens


	
		
__________________________________ 
Yahoo! Mail - PC Magazine Editors' Choice 2005 
http://mail.yahoo.com
