Message-ID: <1080392704316.mikko.alutoin.43848.uGS3d1btYeEEn83ShTq8Yg@luukku.com>
Date: Sat, 27 Mar 2004 15:05:04 +0200 (EET)
From: Mikko Alutoin <mikko.alutoin@luukku.com>
To: Dan Malek <dan@embeddededge.com>,
	Mikko Alutoin <mikko.alutoin@luukku.com>
Subject: Re: Problem with MMU again
Cc: linuxppc-embedded@lists.linuxppc.org
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I traced over the rfi-instruction for a reason: I was not able to break at start_kernel, but setting a breakpoint at start_here worked ok. Also, tracing over the rfi with a working kernel took me directly to start_kernel. So I thought MMU was to blame, but little did I know...

Thanks for the reply, I'll try your advice when I get back to work on Monday.

Cheers, Mikko

> You are chasing ghosts.  There is nothing wrong with the MMU
> initialization.
> There are just times during the initialization that the system and the
> BDI2000
> are not exactly in sync.  This is one of them.
>
> Let the code run, do some post-mortem debugging (like dumping out the
> console log buffer for starters).  Work backward from the failure
>  instead
> of trying to step into it (pun intended) :-)
>
>
> 	-- Dan
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
