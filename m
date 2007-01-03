Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7390DDDED4
	for <linuxppc-dev@ozlabs.org>; Thu,  4 Jan 2007 07:37:49 +1100 (EST)
Subject: Re: R_PPC_ADDR16_HI relocs in PPC modules ?
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Simon Vallet <linux-ppc@castalie.org>
In-Reply-To: <20070103113238.0d99b015.linux-ppc@castalie.org>
References: <20070102172554.7a94cd37@mlejnas.priv.castalie.org>
	<1167770486.6165.70.camel@localhost.localdomain>
	<20070103080151.214ebb62@mlejnas.priv.castalie.org>
	<1167818293.6165.143.camel@localhost.localdomain>
	<20070103113238.0d99b015.linux-ppc@castalie.org>
Content-Type: text/plain
Date: Thu, 04 Jan 2007 07:36:43 +1100
Message-Id: <1167856603.6165.145.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-01-03 at 11:32 +0100, Simon Vallet wrote:
> On Wed, 03 Jan 2007 20:58:12 +1100
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> > Doh ! I've been in "contact" with that driver in a previous life... it's
> > a whole bunch of horrid C++ with windows wrappers all over... or did
> > they improve it ? It's still an ST chip ?
> 
> Well -- obviously I can't tell much about the source ;-), but it
> certainly looks like C++ to me. The last version of the driver is some
> years old, actually, so it probably hasn't changed much since you were
> "in contact" with it -- and yes, as far as I know the card still uses an
> ST chipset.
> 
> Since you're somewhat familiar with this driver, do you
> think the ELF translation approach is a viable one ?

No idea.

Ben.
