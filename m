Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 314E1DDF45
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 22 Mar 2007 02:43:20 +1100 (EST)
To: Valentine Barshak <vbarshak@ru.mvista.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] PPC440EPx/440GRx Sequoia/Rainier board support. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 21 Mar 2007 17:50:06 +0300."
	<4601461E.9010006@ru.mvista.com>
Date: Wed, 21 Mar 2007 16:43:17 +0100
Sender: wd@denx.de
Message-Id: <20070321154317.924703535D3@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Valentine,

in message <4601461E.9010006@ru.mvista.com> you wrote:
>
> Add AMCC PPC440EPx/440GRx Sequoia/Rainier board support.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Signed-off-by: Valentine Barshak <vbarshak@ru.mvista.com>

Umm...

> --- linux.orig/arch/ppc/platforms/4xx/ppc440epx.c	1970-01-01 03:00:00.000000000 +0300
> +++ linux/arch/ppc/platforms/4xx/ppc440epx.c	2007-03-20 14:43:37.000000000 +0300
> @@ -0,0 +1,284 @@
> +/*
> + * arch/ppc/platforms/4xx/ppc440epx.c
> + *
> + * PPC440EPx I/O descriptions
> + *
> + * Wade Farnsworth <wfarnsworth@mvista.com>
> + * Copyright 2004-2007 MontaVista Software Inc.
> + * Copyright 2006 AMCC

The same file in our repository looks like this:

/*
 * arch/ppc/platforms/4xx/ppc440epx.c
 *
 * PPC440EPx I/O descriptions
 *
 * Copyright 2007 DENX Software Engineering, Stefan Roese <sr@denx.de>
 *
 * Wade Farnsworth <wfarnsworth@mvista.com>
 * Copyright 2004 MontaVista Software Inc.
 * Copyright 2006 AMCC


In other words: You *removed* Stefan Roese's (resp.  DENX)  Copyright
entry, and replaced it by one for MV?


I think this was not done by accident.

I don't know what to say.


I think your patches should be rejected.


Wolfgang Denk

-- 
DENX Software Engineering GmbH, HRB 165235 Munich, CEO: Wolfgang Denk
Office:  Kirchenstr. 5,       D-82194 Groebenzell,            Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"If you own a machine, you are in turn owned by it,  and  spend  your
time serving it..."    - Marion Zimmer Bradley, _The Forbidden Tower_
