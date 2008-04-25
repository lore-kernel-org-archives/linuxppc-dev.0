Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id AAE51DE177
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 00:50:53 +1000 (EST)
Subject: Re: HR timers on PowerPC 83xx
From: Joakim Tjernlund <joakim.tjernlund@transmode.se>
To: Sergei Shtylyov <sshtylyov@ru.mvista.com>
In-Reply-To: <4811E845.2060509@ru.mvista.com>
References: <1209132039.31117.17.camel@gentoo-jocke.transmode.se>
	<4811E845.2060509@ru.mvista.com>
Content-Type: text/plain
Date: Fri, 25 Apr 2008 16:50:51 +0200
Message-Id: <1209135051.31117.19.camel@gentoo-jocke.transmode.se>
Mime-Version: 1.0
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
Reply-To: joakim.tjernlund@transmode.se
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Fri, 2008-04-25 at 18:18 +0400, Sergei Shtylyov wrote:
> Hello.
> 
> Joakim Tjernlund wrote:
> 
> > Trying to understand what is needed to make nanosleep() and friends to
> > have better resolution than HZ on my 83xx CPU. Is this possible
> > and what CONFIG options do I need to enable? Kernel is 2.6.25
> 
>     Should be possible with CONFIG_HIGH_RES_TIMERS=y.

What about NO_HZ? Does that setting change anything?

> 
> WBR, Sergei
> 
