Return-Path: <sachinp@in.ibm.com>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6F93BB7B65
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 24 Aug 2009 19:07:18 +1000 (EST)
Message-ID: <4A925838.2090201@in.ibm.com>
Date: Mon, 24 Aug 2009 14:37:04 +0530
From: Sachin Sant <sachinp@in.ibm.com>
MIME-Version: 1.0
To: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
Subject: Re: [PATCH for 2.6.31] powerpc/ps3: Add missing check for PS3 to
	rtc-ps3 platform device registration
References: <4A923AD3.1020507@in.ibm.com> <1251099552.19818.4.camel@concordia>
	<alpine.LRH.2.00.0908241053190.31587@vixen.sonytel.be>
In-Reply-To: <alpine.LRH.2.00.0908241053190.31587@vixen.sonytel.be>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Cc: cbe-oss-dev@ozlabs.org, Linux/PPC Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Geert Uytterhoeven wrote:
> On non-PS3, we get:
>
> | kernel BUG at drivers/rtc/rtc-ps3.c:36!
>
> because the rtc-ps3 platform device is registered unconditionally in a kernel
> with builtin support for PS3.
>
> Reported-by: Sachin Sant <sachinp@in.ibm.com>
> Signed-off-by: Geert Uytterhoeven <Geert.Uytterhoeven@sonycom.com>
> ---
>  arch/powerpc/platforms/ps3/time.c |    4 ++++
>  1 files changed, 4 insertions(+), 0 deletions(-)
Thanks, boots fine now.

Tested-by : Sachin Sant <sachinp@in.ibm.com>

Regards
-Sachin

-- 

---------------------------------
Sachin Sant
IBM Linux Technology Center
India Systems and Technology Labs
Bangalore, India
---------------------------------
