Return-Path: <eemingliu@hotmail.com>
Received: from bay0-omc3-s31.bay0.hotmail.com (bay0-omc3-s31.bay0.hotmail.com
	[65.54.246.231]) by ozlabs.org (Postfix) with ESMTP id 3C014679FC
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  7 Jul 2006 00:04:23 +1000 (EST)
Message-ID: <BAY110-F14AAB7BEB55C4563A4598AB2770@phx.gbl>
In-Reply-To: <44AD108A.8050802@gmail.com>
From: "Ming Liu" <eemingliu@hotmail.com>
To: ammubhai@gmail.com
Subject: Re: Xilinx BSP for linux 2.6
Date: Thu, 06 Jul 2006 14:04:21 +0000
Mime-Version: 1.0
Content-Type: text/plain; charset=gb2312; format=flowed
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

Dear Ameet,

>   I DONOT have a ML403 with me. But does Xilinx EDK generate
>xparameters_ml300.h in the BSP instead of xparameters_ml403.h for the
>ML403 board?

Yes. EKD only generates ml300.h instead of ml403.h, although you specify 
the platform is ML403.


>You need to just copy the xparameters_ml300.h file (if that is what
>xilinx EDK generates) as xparameters_ml403.h in
>arch/ppc/platforms/4xx/xparameters/ folder. Configure the kernel as ML403.

I don't think so. I have looked into these two files. I found that there 
are many differences between them. Not only the addresses for each 
peripheral are different, but also the parameters' names. So If we just 
simply copy ml300.h file as ml403.h, many parameters will be undefined. 

>Like I said to you before, if you want to get started quickly and
>without much headache.. then please go step-by-step. Try the things I
>mention in the article PART I without applying any patches.

Thanks for your suggestion. I will start from the beginning. 

>Please DONOT hesitate to ask further clarifications!

It is really like a big family in the Linux world because of the help among 
the persons. Thanks for all the help from the friends in Linux world!

Regards
Ming

_________________________________________________________________
√‚∑—œ¬‘ÿ MSN Explorer:   http://explorer.msn.com/lccn/  
