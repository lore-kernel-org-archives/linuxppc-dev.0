Return-Path: <domen.puncer@telargo.com>
Received: from out001.atlarge.net (out001.atlarge.net [129.41.63.69])
	by ozlabs.org (Postfix) with ESMTP id 2FB1EDDE18
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 21 Aug 2007 15:49:58 +1000 (EST)
Date: Tue, 21 Aug 2007 07:49:54 +0200
From: Domen Puncer <domen.puncer@telargo.com>
To: Matt Sealey <matt@genesi-usa.com>
Subject: Re: [RFC PATCH v0.1] net driver: mpc52xx fec
Message-ID: <20070821054954.GM13994@moe.telargo.com>
References: <20070810095153.GC13994@moe.telargo.com>
	<20070818100643.GA31233@nd47.coderock.org>
	<46C8643B.7010104@genesi-usa.com>
	<20070820083137.GJ13994@moe.telargo.com>
	<20070820131346.GA2406@nd47.coderock.org>
	<46C9E562.7030601@genesi-usa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <46C9E562.7030601@genesi-usa.com>
Cc: Domen Puncer <domen@coderock.org>, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On 20/08/07 20:02 +0100, Matt Sealey wrote:
> Are you sure this is correct for the Efika?

It works (tm).

> 
> The MPC5200B manual makes a decent distinction between MII operation and
> straight MDIO?

Uh? From what I read MDIO are the lines of MII.


	Domen

> 
> -- 
> Matt Sealey <matt@genesi-usa.com>
> Genesi, Manager, Developer Relations
> 
> Domen Puncer wrote:
> >On 20/08/07 10:31 +0200, Domen Puncer wrote:
> >>On 19/08/07 16:39 +0100, Matt Sealey wrote:
> >>>Domen,
> >>>
> >>>Do it in a Forth script, or in nvramrc (after probe-all). Don't clutter
> >>>Linux with more fixups. The Efika PHY isn't going to change to something
> >>>else and it's a bog standard no-frills MII PHY anyway.
> >>Fine with me, but I'm worried people won't update nvramrc.
> >>
> >...
> >>But I have a problem with it, possibly due to my not-knowledge of Forth.
> >>Compatible keep getting set to:
> >>	compatible            "/builtin/etherne"
> >
> >I missed the encode-string.
> >
> >Matt, can you please add attached Forth script to Efika updates.
> >
> >
> >	Domen
