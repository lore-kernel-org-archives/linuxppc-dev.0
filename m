Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp14.mail.mci.yahoo.co.jp (ybbsmtp14.mail.mci.yahoo.co.jp
	[210.80.241.188]) by ozlabs.org (Postfix) with SMTP id 9013667A6B
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  9 Mar 2005 04:08:42 +1100 (EST)
Message-ID: <422DDC16.5010008@ybb.ne.jp>
Date: Wed, 09 Mar 2005 02:08:38 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <42282C7F.4010407@jp.fujitsu.com>
	<5e548efff8924e163b562381a93ffe35@freescale.com>
In-Reply-To: <5e548efff8924e163b562381a93ffe35@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] WDT Driver for Book-E [1/2] Architecture specific part.
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

Kumar Gala wrote:
> Out of interest how did you test this?  If I find some time I will test  
> it on an e500 system, just havent given much thought on how to test the  
> watchdog though.
> 
> - kumar
> 
I tested the WDT driver with folowing test programs:

1) API test program which tests ioctl commands.
2) Test program which tests the behavior of the driver when
    system hung up due to making interrupt disabled(MSR[EE]=0 case).
    This test program is made as a kernel module.

Shall I send these programs off-list?

Regards,
-- 
Takeharu KATO
