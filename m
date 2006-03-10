Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id E484067A5D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 18:22:21 +1100 (EST)
Received: from localhost (localhost [127.0.0.1])
	by protonic.prtnl (Postfix) with ESMTP id 425B729ECA
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:20:42 +0100 (CET)
Received: from protonic.prtnl ([127.0.0.1])
	by localhost (protonic [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 18585-01 for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:20:40 +0100 (CET)
Received: from archvile (unknown [192.168.1.153])
	by protonic.prtnl (Postfix) with ESMTP id 494AD29EC9
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 10 Mar 2006 08:20:40 +0100 (CET)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Subject: Re: Stable Linux kernel 2.6 for MPC8XX
Date: Fri, 10 Mar 2006 08:22:42 +0100
References: <1CFEB358338412458B21FAA0D78FE86D02CABEE3@rennsmail02.eu.thmulti.com>
In-Reply-To: <1CFEB358338412458B21FAA0D78FE86D02CABEE3@rennsmail02.eu.thmulti.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200603100822.42764.david.jander@protonic.nl>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 08 March 2006 15:29, Fillod Stephane wrote:
> >I would want to use a linux kernel 2.6 on a custom MPC8xx board.
> >Which stable kernel release must or can I use ?
>
> http://www.denx.de/wiki/bin/view/Know/Linux24vs26

I believe most of those observations and measurements are not valid anymore.
Kernel 2.6 for 8xx has come a long way since this article was written. It 
might have been true back then, but it surely isn't anymore.
Kernel 2.6 is bigger than 2.4, that's a fact, but application performance is 
actually slightly higher with 2.6.14 than it is with 2.4.25.
The overall robustness and "niceness" of the code is also a totally different 
story now. 2.6 software architecture is definitely better, and many drivers 
are much more stable. Implementing board support and drivers in 2.6 is also 
much easier and cleaner than in 2.4.

Greetings,

-- 
David Jander
Protonic Holland.
