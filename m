Return-Path: <takeharu1219@ybb.ne.jp>
Received: from ybbsmtp11.mail.mci.yahoo.co.jp (ybbsmtp11.mail.mci.yahoo.co.jp
	[210.80.241.185]) by ozlabs.org (Postfix) with SMTP id DFF3167A79
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  4 Mar 2005 02:21:16 +1100 (EST)
Message-ID: <42272B69.8000303@ybb.ne.jp>
Date: Fri, 04 Mar 2005 00:21:13 +0900
From: Takeharu KATO <takeharu1219@ybb.ne.jp>
MIME-Version: 1.0
To: Kumar Gala <kumar.gala@freescale.com>
References: <4226FF62.30007@jp.fujitsu.com>
	<c56d8feba0d803d74d77ab20f54287e9@freescale.com>
In-Reply-To: <c56d8feba0d803d74d77ab20f54287e9@freescale.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ppcembed <linuxppc-embedded@ozlabs.org>
Subject: Re: PowerPC4xx Watchdog
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Kumar,

Thank you for your suggestion.
Kumar Gala wrote:
> One thing the code needs is a general name cleanup.  Its just confusing 
> to me for e500 to have 4xx references.
> 
How about the use of booke instead of 4xx?

I seem to use ``booke'' for common name for them like 
arch/ppc/kernel/head_booke.h in the kernel source.

Strictly speaking, PowerPC4xx series may not be called booke.
But I think that it is more preferable than current name.

-- 
Takeharu KATO
