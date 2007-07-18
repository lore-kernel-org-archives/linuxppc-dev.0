Return-Path: <vitb@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id F3736DE489
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Jul 2007 05:07:20 +1000 (EST)
Date: Wed, 18 Jul 2007 21:24:00 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH 52/61] cpm_uart: Issue STOP_TX command before
	initializing console.
Message-ID: <20070718212400.44d345ad@localhost.localdomain>
In-Reply-To: <469E416E.8040709@freescale.com>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013608.GX15238@ld0162-tx32.am.freescale.net>
	<20070718120022.1b007937@localhost.localdomain>
	<469E416E.8040709@freescale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 18 Jul 2007 11:35:58 -0500
Scott Wood wrote:

> Vitaly Bordug wrote:
> >>+	cpm_line_cr_cmd(pinfo, CPM_CR_STOP_TX);
> >>+
> > 
> > 
> > I am recalling exactly the contrary patch that removes stuff to get
> > the non-console UARTs work. Let's better revalidate this once other
> > pieces will be in before applying.
> 
> I tried non-console UARTs and had no problem...  How would this 
> interfere with them?  Especially as we're only doing it in the
> console init path...

Bah, what I am recalling has nothing to do with console path so nm.

-- 
Sincerely, Vitaly
