Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp10.mail.mci.yahoo.co.jp (ybbsmtp10.mail.mci.yahoo.co.jp
	[210.80.241.184]) by ozlabs.org (Postfix) with SMTP id 5FD2867A06
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 18 May 2005 03:36:15 +1000 (EST)
Message-ID: <428A2CCD.5070704@ybb.ne.jp>
Date: Wed, 18 May 2005 02:41:33 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <428A040D.40604@ybb.ne.jp>
	<fb7df67f9dda2794b4af2dfa9b4754ca@freescale.com>
In-Reply-To: <fb7df67f9dda2794b4af2dfa9b4754ca@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Glenn Burkhardt <glenn@aoi-industries.com>,
	"Gala Kumar K.-galak" <galak@freescale.com>, linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH] BOOKE_WDT Part 1/2 (Re: PPC 44x Watchdog timer)
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar:

> 
> Yes, I think with these changes to us early_param() for command line 
> parsing in a single place will make the first patch look good.
>
OK, I'll perform this fix in this week.

> I'm still not sure what suggestions I have for the second patch, I was 
> more just letting you know my thinking about the fact that it concerned 
> me that the exception handler code was not in arch/ppc/kernel.  Not to 
> say this is wrong, it just doesn't feel write.
> 
Hum, I agree this thing, I'll move the WDT exception handler to 
arch/ppc/kernel for the moment.
If someone disagree with this decision in the future, I'll move this 
into driver code again.
