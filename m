Return-Path: <jm_ppc@comcast.net>
Received: from rwcrmhc14.comcast.net (rwcrmhc14.comcast.net [216.148.227.89])
	by ozlabs.org (Postfix) with ESMTP id C8CE5679E1
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 15 May 2005 00:05:11 +1000 (EST)
Message-ID: <428604DF.10107@comcast.net>
Date: Sat, 14 May 2005 10:02:07 -0400
From: Josh <jm_ppc@comcast.net>
MIME-Version: 1.0
To: linuxppc-embedded@ozlabs.org
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Subject: reg_book.h changes
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi -

I was just wondering why the MSR_DE bit was removed from the MSR_KERNEL 
define in reg_booke.h(was removed in a 2.6.10 patch). 

This "breaks" debugging with the bdi2000 - depending on the reason it 
was removed, maybe it might be better to modify it in such a way so that 
if CONFIG_BDI_SWITCH is enabled, the MSR_DE bit will also be set?

Thanks,
Josh
