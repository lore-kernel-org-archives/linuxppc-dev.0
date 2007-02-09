Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8A37FDDEC1
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 12:00:13 +1100 (EST)
Subject: Re: [PATCH] Added QE to the list of default scanned OF devices
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <008C1527-AE34-4595-BF45-EF20036FF53B@kernel.crashing.org>
References: <Pine.LNX.4.61.0702081056250.15256@ld0175-tx32.am.freescale.net>
	<1170973667.2620.376.camel@localhost.localdomain>
	<99661347-5376-4D6A-9273-FAEC8C627A31@kernel.crashing.org>
	<008C1527-AE34-4595-BF45-EF20036FF53B@kernel.crashing.org>
Content-Type: text/plain
Date: Fri, 09 Feb 2007 12:00:05 +1100
Message-Id: <1170982805.2620.386.camel@localhost.localdomain>
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

On Thu, 2007-02-08 at 17:25 -0600, Kumar Gala wrote:
> On Feb 8, 2007, at 4:56 PM, Kumar Gala wrote:
> 
> >
> > On Feb 8, 2007, at 4:27 PM, Benjamin Herrenschmidt wrote:
> >
> >> On Thu, 2007-02-08 at 10:56 -0600, Andy Fleming wrote:
> >>> Signed-off-by: Andrew Fleming <afleming@freescale.com>
> >>> ---
> >>>  arch/powerpc/kernel/of_platform.c |    1 +
> >>>  1 files changed, 1 insertions(+), 0 deletions(-)
> >>
> >> As I said several times on irc, I dislike the "default list" and I'm
> >> tempted to remove it. I'd much prefer if your platform passed in the
> >> list of what it wants exposed.
> >
> > How about we add 'qe' for now and look at removing the list going
> > forward.
> 
> Actually, nevermind.  I've dropped the patch and will make the guys  
> do what you are suggesting.  Can you look at the other users (cell,  
> pmac?) and change them so we can remove the "default list"

Only Cell is using that afaik. I'll do a patch asap.

Ben.
