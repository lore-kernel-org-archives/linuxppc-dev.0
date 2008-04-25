Return-Path: <joakim.tjernlund@transmode.se>
Received: from tmnt04.transmode.se (mail.transmode.se [83.241.175.147])
	by ozlabs.org (Postfix) with ESMTP id 4F1D4DE328
	for <linuxppc-dev@ozlabs.org>; Sat, 26 Apr 2008 04:30:06 +1000 (EST)
From: "Joakim Tjernlund" <Joakim.Tjernlund@transmode.se>
To: "'Sergei Shtylyov'" <sshtylyov@ru.mvista.com>
References: <1209132039.31117.17.camel@gentoo-jocke.transmode.se>	
	<4811E845.2060509@ru.mvista.com>
	<1209135051.31117.19.camel@gentoo-jocke.transmode.se>
	<4811FFE4.2020203@ru.mvista.com>
In-Reply-To: <4811FFE4.2020203@ru.mvista.com>
Subject: RE: HR timers on PowerPC 83xx
Date: Fri, 25 Apr 2008 20:29:37 +0200
Message-ID: <003601c8a702$51535c90$f3fa15b0$@Tjernlund@transmode.se>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Cc: 'linuxppc-dev Development' <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

> -----Original Message-----
> From: Sergei Shtylyov [mailto:sshtylyov@ru.mvista.com]
> Sent: den 25 april 2008 18:00
> To: joakim.tjernlund@transmode.se
> Cc: 'linuxppc-dev Development'
> Subject: Re: HR timers on PowerPC 83xx
> 
> Joakim Tjernlund wrote:
> 
> >>>Trying to understand what is needed to make nanosleep() and friends to
> >>>have better resolution than HZ on my 83xx CPU. Is this possible
> >>>and what CONFIG options do I need to enable? Kernel is 2.6.25
> 
> >>    Should be possible with CONFIG_HIGH_RES_TIMERS=y.
> 
> > What about NO_HZ? Does that setting change anything?
> 
>     It is independent from HRT and selects the mode where the idle process
> stops timer HZ interrupts from occuring until it's scheduled off CPU.

OK, Thanks

One last question, do I need a current glibc to use
the new resolution? I got 2.3.6 now

     Jocke
