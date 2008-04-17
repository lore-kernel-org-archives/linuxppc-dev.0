Return-Path: <SRS0+717c909e079b4f65c96e+1698+infradead.org+dwmw2@pentafluge.srs.infradead.org>
Received: from pentafluge.infradead.org (pentafluge.infradead.org
	[213.146.154.40])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5A38EDE851
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Apr 2008 01:11:57 +1000 (EST)
Subject: Re: [EFIKA] Really, don't pretend to be CHRP
From: David Woodhouse <dwmw2@infradead.org>
To: Matt Sealey <matt@genesi-usa.com>
In-Reply-To: <4807427B.3030902@genesi-usa.com>
References: <1208105558.3026.137.camel@pmac.infradead.org>
	<4807427B.3030902@genesi-usa.com>
Content-Type: text/plain
Date: Thu, 17 Apr 2008 15:37:37 +0100
Message-Id: <1208443057.9212.250.camel@pmac.infradead.org>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-04-17 at 13:28 +0100, Matt Sealey wrote:
> I thought we were using efika.forth for this in Fedora.

We were, until you pointed out that the kernel actually works just fine
these days without it.

Now, the _only_ thing that goes wrong without it is that 'CHRP' in the
machine: line -- which is fixed by this patch. And so the user's life is
made easier -- all they have to work around now is the fact that we
can't set environment variables from within Linux (and yes, we can
probably improve on that too, but we let them setenv for themselves, for
now).

> Why don't we just roll all those fixes into prom_efika.c or something
> and make it a huge, unwieldy file nice and *seperate* from
> prom_init.c?

That might be a little cleaner than what we have at the moment, yes. But
what we have also works, so I'd rather concentrate on things like
getting audio support merged, before we faff around with what are
essentially cosmetics.

-- 
dwmw2
