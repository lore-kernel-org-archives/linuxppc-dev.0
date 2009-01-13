Return-Path: <gerhard_pircher@gmx.net>
Received: from mail.gmx.net (mail.gmx.net [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id CDF74DDF91
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Jan 2009 23:33:40 +1100 (EST)
Content-Type: text/plain; charset="us-ascii"
Date: Tue, 13 Jan 2009 13:33:37 +0100
From: "Gerhard Pircher" <gerhard_pircher@gmx.net>
In-Reply-To: <1231822958.22571.38.camel@pasglop>
Message-ID: <20090113123337.199060@gmx.net>
MIME-Version: 1.0
References: <20090112233909.221080@gmx.net> <1231822958.22571.38.camel@pasglop>
Subject: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne
	boards
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


-------- Original-Nachricht --------
> Datum: Tue, 13 Jan 2009 16:02:38 +1100
> Von: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> An: Gerhard Pircher <gerhard_pircher@gmx.net>
> CC: Bartlomiej Zolnierkiewicz <bzolnier@gmail.com>, grant.likely@secretlab.ca, linuxppc-dev@ozlabs.org, linux-ide@vger.kernel.org
> Betreff: Re: [PATCH 5/5] ide: Force VIA IDE legacy interrupts for AmigaOne boards

> > Yes, it can wait.
> > Although I would like to know from the powerpc maintainer, if my
> > platform patches could still go in 2.6.29, if I resend them in the next days? I
> > guess it's too late, right?
> 
> Yes it is. I'll put them in -next after -rc2 or later, when we are happy
> with them. That gives us a bit of time to do extra polishing.
Good, then I'll send out a new patch for the IDE driver and the current one
can be reverted.

Gerhard
