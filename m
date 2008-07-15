Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id DD414DE8BA
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:09:49 +1000 (EST)
Message-Id: <20510121-E683-475F-8B40-7C26F346FC2D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: avorontsov@ru.mvista.com
In-Reply-To: <20080715160048.GA31615@polina.dev.rtsoft.ru>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: GPIO drivers, other patches?
Date: Tue, 15 Jul 2008 11:09:40 -0500
References: <AB4393B8-8578-4AFA-B23A-048F86A9A24D@kernel.crashing.org>
	<20080715160048.GA31615@polina.dev.rtsoft.ru>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 15, 2008, at 11:00 AM, Anton Vorontsov wrote:

> On Tue, Jul 15, 2008 at 10:10:21AM -0500, Kumar Gala wrote:
>> Anton,
>>
>> I think I've gotten most of the patches from you,
>
> Yes, much thanks!
>
>> but I know there are
>> few I've lost.  Can you just repost any patches that aren't in my
>> powerpc-next tree.
>
> Only this minor patch is missing:
>
> [PATCH v3] powerpc/83xx: update mpc83xx_defconfig to support  
> MPC8360E-RDK
> http://patchwork.ozlabs.org/linuxppc/patch?id=18903

This one I'll hold off on until we update defconfigs after an -rc or  
two.

> There are also last two patches I need to rework a bit (to be in
> compliance with latest power management work done by Scott Wood):
>
> [PATCH 1/2] [POWERPC] 86xx: suspend support
> http://patchwork.ozlabs.org/linuxppc/patch?id=18836
>
> [PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add wakeup-on-sw9 support
> http://patchwork.ozlabs.org/linuxppc/patch?id=18837
>
> I'll resubmit them today or tomorrow. (Though, I'll appreciate if you
> will look into these two, maybe you'll have any comments I can fix
> before resubmitting).

I want to hold off on these two patches.  I'd like to understand how  
the function in the larger 8xxx PM world.  I've applied Scott's 83xx  
PM patches for sleep and clearly we are doing a lot more work than on  
86xx.

- k
