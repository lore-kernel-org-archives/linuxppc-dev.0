Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9974167A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Mar 2006 01:38:08 +1100 (EST)
In-Reply-To: <000201c63c44$14a9c1b0$5201a8c0@GEG2400>
References: <000201c63c44$14a9c1b0$5201a8c0@GEG2400>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0B99478F-EAB3-4070-AA8E-81418BF4BFBE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Minor bug in file irq.h
Date: Tue, 28 Feb 2006 08:38:02 -0600
To: Laurent Lagrange <lagrange@fr.oleane.com>
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


On Feb 28, 2006, at 2:50 AM, Laurent Lagrange wrote:

>
> Hello,
>
> I use a Linux 2.6.9 on MPC85xx.
>
> In the ./linux/include/asm-ppc/irq.h file, I encountered a problem  
> with the
> timer3 interrupt definition :
> #define     SIU_INT_TIMER3          ((uint)0x0e+CPM_IRQ_OFFSET)
>
> This definition generates a compilation error  because is  
> interpreted as
> something like
> ((uint)0x0(e+CPM_IRQ_OFFSET)) ie 0x0 exponent  + CPM_IRQ_OFFSET.
>
> To work around just parenthesis or add a space character between  
> 'e' and '+'
> #define     SIU_INT_TIMER3          ((uint)0x0e +CPM_IRQ_OFFSET)

Do you mind providing this in patch form with a signed-off-by.  I'll  
include it in the queue of 85xx related patches.

- kumar
