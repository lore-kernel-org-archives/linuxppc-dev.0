Return-Path: <jdl@jdl.com>
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: Outstanding DTC patches? 
In-Reply-To: Your message of "Thu, 03 Jan 2008 15:48:43 +1100."
	<20080103044843.GD25357@localhost.localdomain>
References: <1199298062.7345.25.camel@ld0161-tx32>
	<20080103044843.GD25357@localhost.localdomain>
Date: Thu, 03 Jan 2008 08:14:53 -0600
From: Jon Loeliger <jdl@jdl.com>
Message-Id: <E1JAQqT-00056B-FP@jdl.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

So, like, the other day David Gibson mumbled:
> 
> I posted this one a while back, but I guess it dropped through the
> cracks.

Yep, sorry.

> There's also the patch I sent you quite a long time ago that
> adds a clarifying readme about the licensing situation - that might be
> an idea for v1.1, too.

I can not find this; neither locally nor on patchworks.
Do you have a Subject: line, a URL, or could you
please repost it?


> dtc: Remove header information dumping
> 
> Currently, when used in -Idtb mode, dtc will dump information about
> the input blob's header fields to stderr.  This is kind of ugly, and
> can get in the way of dtc's real output.
> 
> This patch, therefore, removes this.  So that there's still a way of
> getting this information for debugging purposes, it places something
> similar to the removed code into ftdump, replacing the couple of
> header fields it currently prints with a complete header dump.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied.

Thanks,
jdl
