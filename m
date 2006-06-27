Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id B6205679FC
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 27 Jun 2006 21:51:52 +1000 (EST)
Date: Tue, 27 Jun 2006 15:51:21 +0400
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Jagan <morphicsk@yahoo.com>
Subject: Re: Reg RISC timers in MPC 8260
Message-ID: <20060627155121.081abb95@localhost.localdomain>
In-Reply-To: <20060627113137.2386.qmail@web36913.mail.mud.yahoo.com>
References: <20060627113137.2386.qmail@web36913.mail.mud.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

На Tue, 27 Jun 2006 04:31:37 -0700 (PDT)
Jagan <morphicsk@yahoo.com> записано:

> Hi all
> 
> We have a requirement of running a periodic timer for
> 5 millisecond using RISC timers in CPM module of
> MPC8260. The OS is monta vista linux and target is
> MPC8260 I have written a sample code to start a
> periodic timer using MPC8260. 
> 
> But it hangs when SET TIMER command is issued to the
> CPCR register. The cross compiler we r using is
> ppc_82xx-gcc.
>  
> Can anyone pls help me in getting this right ?
> 
> I am pasting the code here 
> ------------------------------------------------------
> /*Start of code snippet  ignoring the header files */
> cpm8xx_t	*cpmp;
> 
> volatile immap_t *immap = (immap_t *)IMAP_ADDR;
> 
hrmmm, isn't 8260 CPM2? This is 8xx immap, that is _really_ different
from what 8260 has... Grep for cpm2_immr and look into asm/immap_cpm2.h
for details.

-Vitaly
