Return-Path: <mike@compulab.co.il>
Received: from alex (62-90-235-247.barak.net.il [62.90.235.247])
	by ozlabs.org (Postfix) with ESMTP id B287267C4B
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 17 Jul 2005 16:10:05 +1000 (EST)
Message-ID: <42DA0024.3050005@compulab.co.il>
Date: Sun, 17 Jul 2005 08:52:20 +0200
From: Mike Rapoport <mike@compulab.co.il>
MIME-Version: 1.0
To: SIP COP 009 <sipcop009@gmail.com>
References: <5a4792c0050713235574522cfb@mail.gmail.com>
In-Reply-To: <5a4792c0050713235574522cfb@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: 8272ADS and Linux 2.6.12
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

SIP COP 009 wrote:

>Hello,
>
>We have a MPC8272 Eval Board which came with Linux 2.4 and U-boot. We
>wanted to move to 2.6. I downloaded the latest 2.6.12 sources and
>compiled the sources for this platform. The kernel is built, have run
>the mkimage tool, but the kernel wont boot.  It just hangs after
>decompressing the image.
>
>  
>

>Any ideas  ? Anything different that needs to be done for 2.6 ? Or any
>known issues ?
>
>  
>
If you're using the u-boot that came with MPC8272 Eval board it may 
happen that BCSR is mapped differently in u-boot and the kernel 2.6. 
That's what happened when I tried to boot linux 2.6 on MPC8272ADS. Check 
the value of CFG_BCSR in u-boot/include/configs/MPC8260ADS.h and 
BCSR_ADDR in linux/arch/ppc/platforms/pq2ads.h

>Thanks!
>ashutosh
>  
>
-- 
Sincerely yours,
Mike 
