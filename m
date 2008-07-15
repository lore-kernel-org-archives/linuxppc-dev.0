Return-Path: <avorontsov@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 54E5EDDFC8
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jul 2008 02:00:51 +1000 (EST)
Date: Tue, 15 Jul 2008 20:00:48 +0400
From: Anton Vorontsov <avorontsov@ru.mvista.com>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: GPIO drivers, other patches?
Message-ID: <20080715160048.GA31615@polina.dev.rtsoft.ru>
References: <AB4393B8-8578-4AFA-B23A-048F86A9A24D@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf8
In-Reply-To: <AB4393B8-8578-4AFA-B23A-048F86A9A24D@kernel.crashing.org>
Cc: Scott Wood <scottwood@freescale.com>,
	linuxppc-dev list <linuxppc-dev@ozlabs.org>
Reply-To: avorontsov@ru.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jul 15, 2008 at 10:10:21AM -0500, Kumar Gala wrote:
> Anton,
>
> I think I've gotten most of the patches from you, 

Yes, much thanks!

> but I know there are  
> few I've lost.  Can you just repost any patches that aren't in my  
> powerpc-next tree.

Only this minor patch is missing:

[PATCH v3] powerpc/83xx: update mpc83xx_defconfig to support MPC8360E-RDK
http://patchwork.ozlabs.org/linuxppc/patch?id=18903


There are also last two patches I need to rework a bit (to be in
compliance with latest power management work done by Scott Wood):

[PATCH 1/2] [POWERPC] 86xx: suspend support
http://patchwork.ozlabs.org/linuxppc/patch?id=18836

[PATCH 2/2] [POWERPC] 86xx: mpc8610_hpcd: add wakeup-on-sw9 support
http://patchwork.ozlabs.org/linuxppc/patch?id=18837

I'll resubmit them today or tomorrow. (Though, I'll appreciate if you
will look into these two, maybe you'll have any comments I can fix
before resubmitting).

Thanks again,

-- 
Anton Vorontsov
email: cbouatmailru@gmail.com
irc://irc.freenode.net/bd2
