Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao08.cox.net (fed1rmmtao08.cox.net [68.230.241.31])
	by ozlabs.org (Postfix) with ESMTP id A486967A77
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 12:43:39 +1100 (EST)
Date: Wed, 16 Feb 2005 18:43:36 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: "Andre' Draszik" <andid@gmx.net>
Message-ID: <20050216184335.A1530@cox.net>
References: <4206ED97.2060506@gmx.net> <20050216161432.B31885@cox.net>
	<4213F112.2060606@gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4213F112.2060606@gmx.net>;
	from andid@gmx.net on Thu, Feb 17, 2005 at 02:19:14AM +0100
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] PPC4xx ocp ide rewrite/cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 17, 2005 at 02:19:14AM +0100, Andre' Draszik wrote:
> Hi,
> 
> Matt Porter wrote:
> > On Mon, Feb 07, 2005 at 05:24:55AM +0100, Andre' Draszik wrote:
> > 
> >>Hi,
> >>
> >>this is a rewrite of the ibm4xx ocp ide driver. In its current state it
> >>[...]
> > 
> > I tried applying this to current linuxppc-2.5. All hunks are rejected.
> > Can you double check this patch and resend?
> 
> my kernel tree is
> rsync -avz --delete source.mvista.com::linuxppc-2.5 linuxppc-2.5
> and as of 16.02.05 23:44GMT the patch still applies. so did i really
> send a wrong patch or has the rsync mirror just not yet been
> updated? or is it a whitespace issue?
> 
> just checked - it's the last, so here's the patch, rediffed to
> 2.6.11-rc4, as attachment, not inline this time.

Ok, this worked...looks like your mailer mangled whitespace on
the inlined patch. It applied to BK linuxppc-2.5 and I'll take
a look in a bit. Ultimately, we need to get this driver into
linux-2.5.

Thanks,
Matt
