Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2BF85B7B7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  6 Oct 2009 21:51:59 +1100 (EST)
Subject: Re: SMU-base PowerMac and server_mode
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Romain Goyet <r.goyet@gmail.com>
In-Reply-To: <8028e5750910060331m42ea795bi441eb7a9b39837f8@mail.gmail.com>
References: <8028e5750910060216x134a8a9cm461fa5a6e87eb6bb@mail.gmail.com>
	<1254823882.6035.5.camel@pasglop>
	<8028e5750910060331m42ea795bi441eb7a9b39837f8@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 06 Oct 2009 21:51:52 +1100
Message-Id: <1254826312.6035.8.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-06 at 12:31 +0200, Romain Goyet wrote:
> Hi Benjamin !
> 
> 
>   Actually I saw a post where you mentioned this tool on Google. I
> then searched it for like an hour or so, but really couldn't find it.
> That's why I ended up posting on this mailing list. I'm really glad
> you're on it by the way ! Anyway, like I said : I really looked for
> this tool, but couldn't find it…

Hrm... ok. I'll have to figure it out again. No time right now, but
get back to me next month after Kernel Summit and I'll see what i can
do.

Cheers,
Ben.

> 
> Thanks a lot !
> 
> 
>  - Romain
> 
> 
> On Tue, Oct 6, 2009 at 12:11 PM, Benjamin Herrenschmidt
> <benh@kernel.crashing.org> wrote:
>         
>         On Tue, 2009-10-06 at 11:16 +0200, Romain Goyet wrote:
>         > Hi there,
>         >
>         >
>         >   I have this Quad G5 here, running GentooPPC64. Runs fine.
>         Had a hard
>         > time getting it to boot without a screen attached, but I
>         eventually
>         > managed to (yaboot was the culprit). However, this machine
>         is
>         > SMU-based, and I couldn't find a way to enable the
>         equivalent of the
>         > PMU's "server_mode" (i.e. automatically reboot after a power
>         failure).
>         > Is there any known way to do that ?
>         
>         
>         I'm pretty sure I reverse engineered the necessary command a
>         while back
>         and somebody wrote a userland tool to set it, but I can't find
>         it
>         anymore :-)
>         
>         Google may help. Let me know if you can't find it.
>         
>         Cheers,
>         Ben.
>         
>         
> 
> 
