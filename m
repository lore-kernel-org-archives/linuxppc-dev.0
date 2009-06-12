Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 81C9BB7312
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 13 Jun 2009 00:01:45 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CA5A6DDD04
	for <linuxppc-dev@ozlabs.org>; Sat, 13 Jun 2009 00:01:44 +1000 (EST)
Subject: Re: "next" branch update
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0906120654m22f38569jea21dfaf9449c34c@mail.gmail.com>
References: <1244791784.7172.69.camel@pasglop>
	<ed82fe3e0906120654m22f38569jea21dfaf9449c34c@mail.gmail.com>
Content-Type: text/plain
Date: Fri, 12 Jun 2009 23:59:27 +1000
Message-Id: <1244815167.7172.166.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-06-12 at 08:54 -0500, Timur Tabi wrote:
> On Fri, Jun 12, 2009 at 2:29 AM, Benjamin
> Herrenschmidt<benh@kernel.crashing.org> wrote:
> > I pushed the following commits, along with merging Linus tree in today.
> 
> Is there a reason you keep ignoring my patch?

Other than I hate you ? just kidding :-)

> [PATCH 1/2 v9] powerpc: introduce macro spin_event_timeout()
> 
> There is PowerPC code in the ALSA tree that depends on my patch, so
> that code will break if you don't push my patch upstream.

I know, and you may have noticed I haven't sent a pull request to Linus
yet... I was planning on scrubbing patchwork once more today and got
sidetracked with fixing the breakage that went into mainline already
while I was not looking :-)

I haven't closed powerpc-next, I know I'm late, but don't worry, your
patch is on my todo list.

Cheers,
Ben.
