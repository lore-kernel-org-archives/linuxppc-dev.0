Return-Path: <jdl@jdl.com>
Received: from jdl.com (jdl.com [208.123.74.7])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5525FDDF12
	for <linuxppc-dev@ozlabs.org>; Tue, 20 Mar 2007 01:10:48 +1100 (EST)
To: Jerry Van Baren <gerald.vanbaren@comcast.net>
Subject: Re: [PATCH] DTC: Improve options handling - respin 
In-Reply-To: Your message of "Sun, 18 Mar 2007 16:49:24 EDT."
	<45FDA5D4.7050004@comcast.net>
References: <45FC1F69.9080204@comcast.net>
	<20070317231337.GA11017@localhost.localdomain>
	<45FDA5D4.7050004@comcast.net>
Date: Mon, 19 Mar 2007 09:10:42 -0500
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1HTIZO-00036N-21@jdl.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day Jerry Van Baren mumbled:
> 
> Hi David, Jon,
> 
> I was just seeing if I could get a rise out of you. It worked. ;-)
> 
> Attached is a respin of my previous two patches: it adds the -h and -q 
> options and #defines the default version but does _not_ delete the -R 
> option (left as an exercise for the reader to make it useful :-).

Please follow the patch layout guideline like this:

    Mail headers with
    From: <"default" author>
    Subject: <patch summary line>

    From: <actual author if different than mail envelope author>

    <detailed log message>

    <sign-off as needed>
    ---

    Notes and commentary

    <actual patch inline text>

As it was, manual patch editing was necessary to dodge
your introductory explanation.

> Subject: [PATCH] Improve options, #define default version.
> 
> Add -h option for help
> Add -q quiet option to reduce or suppress the whining
> Create #define for the default version value.
> 
> Signed-off-by: vanbaren@cideas.com <vanbaren@cideas.com>
> ---

Applied and pushed out!

However, two comments:

> ... but does _not_ delete the -R 
> option (left as an exercise for the reader to make it useful :-).

I'll certainly entertain a patch to fix the reserve space problem. :-)
That could have been my fault, though we both had our fingers in that pie.

> +	fprintf(stderr, "\t-q\n");
> +	fprintf(stderr, "\t\tQuiet: -q suppress warnings, -qq errors, -qqq all\n");

This is a bit misleading.  Sepcifically, -qqq does not currently
suppres "all" messagesm notably	those through yyerror().
An ambitious soul might beat me to fixing that up...


Thanks,
jdl
