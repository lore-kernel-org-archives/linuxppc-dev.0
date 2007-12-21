Return-Path: <paul.gortmaker@windriver.com>
Received: from yow-pgortmak-d1.corp.ad.wrs.com (unknown [209.5.119.169])
	by ozlabs.org (Postfix) with ESMTP id 6886DDDEE9
	for <linuxppc-dev@ozlabs.org>; Sat, 22 Dec 2007 02:37:31 +1100 (EST)
Date: Fri, 21 Dec 2007 10:37:29 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/4] sbc8560: add basic support for Wind River SBC8560
	as powerpc
Message-ID: <20071221153728.GA20661@windriver.com>
References: <11981624722785-git-send-email-paul.gortmaker@windriver.com>
	<11981624732110-git-send-email-paul.gortmaker@windriver.com>
	<20071221101425.3408278c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071221101425.3408278c.sfr@canb.auug.org.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message: Re: [PATCH 1/4] sbc8560: add basic support for Wind River SBC8560 as powerpc
on 21/12/2007 Stephen Rothwell wrote:

> Hi Paul,
> 
> Just a couple of comments.

[...]

> The braces are unnecessary.
> 

[...]

> We often say "if (!np)" and leave out the blank line above.
> 
> > +	if(of_address_to_resource(np, 0, &r)) {
>           ^
> Put a space here.

[...]

> Need an of_node_pit(np) - cpm2_pic_init() does its own of_node_get.
> 
> > +static struct cpm_pin sbc8560_pins[] = {
> 
> const?
> 

Sounds reasonable to me.  I've integrated these into sbc8560.c (still
looking at how to handle the duart/dts based on feedback).  Since I'd
inerited the things you'd requested fixes on from mpc85xx_ads.c, it
probably makes sense to fix them there too I would imagine.  I'll send
that under its own subject in a minute.

Paul.
