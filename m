Return-Path: <vbordug@ru.mvista.com>
Received: from mail.dev.rtsoft.ru (unknown [85.21.88.2])
	by ozlabs.org (Postfix) with SMTP id E6CEF688E6
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 Jan 2006 07:08:23 +1100 (EST)
Date: Tue, 17 Jan 2006 23:08:21 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Jose =?UTF-8?B?RnJhbsOnYQ==?= (Ext_GTBC) <Jose.Franca.Ext@siemens.com>
Subject: Re: Linux-2.4.31 porting
Message-ID: <20060117230821.78c7f822@vitb.dev.rtsoft.ru>
In-Reply-To: <16FD2D70D281D44F9BFCF6ACF9B6117102AF6570@lisi053a.siemens.pt>
References: <16FD2D70D281D44F9BFCF6ACF9B6117102AF6570@lisi053a.siemens.pt>
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

On Tue, 17 Jan 2006 19:33:21 -0000
Jose França (Ext_GTBC) <Jose.Franca.Ext@siemens.com> wrote:

> Hello u all!
> 
> 	Have you already ported a linux-2.4.31 to be used on a PPC mpc8272 (or anyone from the family) based board?
> 	The problem that I have is that i don't have console. As far as i could debug, the kernel stucks on my_console_write (in arch/ppc/cpm2_io/uart.c), waiting for transmitter fifo to empty (line 2298 - "while (bdp->cbd_sc & BD_SC_READY)").
> 	Any suggestions will be highly welcomed!
> 
> 

Better use 2.6 as 8272 is definitely OK there (and it was in 2.4 but I've almost forgotten issues in 2.4)

> 
> Thanks for reading!
> Best regards,
> Filipe.


-- 
Sincerely, 
Vitaly
