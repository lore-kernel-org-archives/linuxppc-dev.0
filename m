Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0205.outbound.protection.outlook.com [207.46.163.205])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BD01F1A0A72
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Aug 2014 04:15:36 +1000 (EST)
Message-ID: <1407521714.7427.70.camel@snotra.buserror.net>
Subject: Re: T1040QDS warm reboot
From: Scott Wood <scottwood@freescale.com>
To: Vineeth <vneethv@gmail.com>
Date: Fri, 8 Aug 2014 13:15:14 -0500
In-Reply-To: <CAFbQSaA80pdzXBk2Om4ewGS9FTWc_tPvu9MM596gPc-_B3igVw@mail.gmail.com>
References: <CAFbQSaA80pdzXBk2Om4ewGS9FTWc_tPvu9MM596gPc-_B3igVw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-08 at 11:35 +0530, Vineeth wrote:
> Was wondering how "reboot" works from linux kernel for t1040qds.
> 
> 
> When checked, @arch/powerpc/sysdev/fsl_soc.c 
> 
> __setup_rstcr, an ioremap is done for the offset 0xb0 and writes 0x2
> to that to reboot the machine. and it works properly.
> 
> 
> when checked the reference manual for T1040QDS, it was given that
> RST_CTL is at offset 0x40 and the RST is the 7th bit of same. 

RSTCR is an SoC register (see DCFG_CCSR_RSTCR in T1040RM), not something
implemented by the board.  Are you perhaps looking at some QIXIS
register?

-Scott
