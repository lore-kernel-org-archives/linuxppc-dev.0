Message-ID: <3C740658.9060706@pacbell.net>
Date: Wed, 20 Feb 2002 20:26:00 +0000
From: Armin <akuster@pacbell.net>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Patch to make ppc_md.progress useful on 4xx
References: <20020221005647.GA19976@zax>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


David Gibson wrote:
> Currently, ppc_md.progress on 4xx just does a printk(), which means
> its messages won't be displayed until console_init() at which point
> it's usually too late to be useful.
>
> The patch below changes ppc4xx_progress() to write directly to the
> serial port.  I'd like to get comments before pushing the change,
> because I don't want to break 4xx machines that I don't have (and so
> can't test).
>
> At the moment it should only affect 405GP.  NP405H and NP405L support
> should be trivial (I've only refrained from adding it because I can't
> test it myself).  STBxxxx should be possible but will be much
> yuckier.  It would be nice to have it work on all 4xx though, to get
> rid of the nasty #ifdef in ppc4xx_setup.c.
>
> --
> David Gibson			| For every complex problem there is a
> david@gibson.dropbear.id.au	| solution which is simple, neat and
> 				| wrong.  -- H.L. Mencken
> http://www.ozlabs.org/people/dgibson
>
>
>
>
>

What Patch?

I can test on some of the boards

--armin


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
