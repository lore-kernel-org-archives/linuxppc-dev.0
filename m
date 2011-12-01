Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 444F71007D4
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Dec 2011 08:39:53 +1100 (EST)
Message-ID: <1322775586.3729.28.camel@pasglop>
Subject: Re: ppc4xx simple vs SoC's
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Fri, 02 Dec 2011 08:39:46 +1100
In-Reply-To: <CA+5PVA5xaCa8Tv3MMr1WzQAuLit9KenMoezOKB7ENQSt=fOSOg@mail.gmail.com>
References: <1322717953.3729.18.camel@pasglop>
 <CA+5PVA5xaCa8Tv3MMr1WzQAuLit9KenMoezOKB7ENQSt=fOSOg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2011-12-01 at 06:44 -0500, Josh Boyer wrote:

> > However, the entry for ppc44x_simple doesn't select any of these,
> > meaning for example, AFAIK, that you don't get EMAC4 etc... I'm
> > surprised things work at all !
> >
> > What am I missing ?
> 
> CONFIG_PPC44x_SIMPLE is selected by the board Kconfig values, which
> also select all of the SoC Kconfig options they need as well.
> ppc44x_simple started as a way to basically avoid duplicating a bunch
> of board.c files, but it's still "driven" from the board options.
> 
> So hopefully that explains how things are working today.  The question
> now is whether you would like something different?

Ok, just getting my head around that stuff, I haven't really looked
since you and Grant I believe came up with the scheme :-) (Was wondering
what to do for currituck, but for now we'll keep it a separate board, at
least until I can decide how to deal with the interrupt quirk).

I just hadn't realized that while we had ppc4xx_simple, we still had
board Kconfig's to enable it.

Cheers,
Ben.
