Return-Path: <vbordug@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 6DCA4DDEE3
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Mar 2007 03:31:22 +1100 (EST)
Date: Fri, 2 Mar 2007 19:32:04 +0300
From: Vitaly Bordug <vbordug@ru.mvista.com>
To: Kenneth Fairweather <kenneth.fairweather@freescale.com>
Subject: Re: errors compiling 2.6.20 for mpc866ads
Message-ID: <20070302193204.3a0e5047@vitb.dev.rtsoft.ru>
In-Reply-To: <200703021625.14661.kenneth.fairweather@freescale.com>
References: <200703021625.14661.kenneth.fairweather@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Fri, 2 Mar 2007 16:25:14 +0000
Kenneth Fairweather <kenneth.fairweather@freescale.com> wrote:

> Compiling a vanilla 2.6.20 kernel and applying Vitaly Bordug's 7 patches (21st 
> Jan'07) for mpc866_ads_defconfig gives compiler errors:
> 
>   LD      arch/powerpc/platforms/8xx/built-in.o
>   LD      arch/powerpc/platforms/built-in.o
>   CC      drivers/net/fs_enet/fs_enet-main.o
> linux-2.6.20/drivers/net/fs_enet/fs_enet-main.c: In function `setup_immap':
> inux-2.6.20/drivers/net/fs_enet/fs_enet-main.c:1139: error: `IMAP_ADDR' 
> undeclared (first use in this function)
>

Please update to current Linus' git and retry. All patches should be in there,
let me know if not and/or something not working.
 
> Are these patches for 2.6.20 kernel, and/or are there other patches required? 
> should I still be using ppc branch?
> 
> Also, tried to grab Vitaly's git tree, but it is failing on http (I'm behind a 
> firewall). Is this a known problem?
> 
> cg-clone http://source.mvista.com/git/linux-2.6-vitb.git
> defaulting to local storage area
> Fetching head...
> cg-fetch: unable to get the HEAD branch
> 
Heh, sort of - I've synced my tree with mainline a while ago which reminds me to have a look at it...

-- 
Sincerely, 
Vitaly
