Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp1.wanadoo.fr (smtp1.wanadoo.fr [193.252.22.30])
	by ozlabs.org (Postfix) with ESMTP id 4C5B567A87
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 25 Feb 2005 03:13:22 +1100 (EST)
Date: Thu, 24 Feb 2005 17:04:11 +0100
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20050224160411.GA11197@pegasos>
References: <41F6E0E1.6000803@mvista.com> <20050224082508.GA30005@pegasos>
	<421DF2B8.6040007@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <421DF2B8.6040007@mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: nd@bplan-gmbh.de, Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH][PPC32] mv64x60 updates
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2005 at 08:28:56AM -0700, Mark A. Greer wrote:
> Sven Luther wrote:
> 
> >On Tue, Jan 25, 2005 at 05:14:25PM -0700, Mark A. Greer wrote:
> > 
> >
> >>Hi Andrew.
> >>
> >>This patch briges the mv64x60 related code up to the latest that I have.
> >>   
> >>
> >
> >Mark, ...
> >
> >I am a bit bewildered by what you are doing here. How does this mv64x60 
> >code
> >relate to the mv643xx_eth driver from the mips folk ? 
> >
> >Friendly,
> >
> >Sven Luther
> >
> 
> Hi Sven.

Hi Mark :)

> The mv64x60 is a Marvell host bridge with some I/O ctlrs including 3 

Yeah, i know, as we use the MV64361 in the Pegasos 2 motherboards here at
Genesi/Bplan.

> enet cltrs.  There are virtually identical versions for MIPS (called 
> mv64x4x) and PPC (called mv64x6x).  The mv643xx_eth driver was 
> originally written by the MIPS folks, as you note, but Dale Farnsworth 

Yes, and is in drivers/net.

> has spent a lot of time making it work on both MIPS and PPC.  The code 
> you see in the mv64x60.c file is a part of that.  I believe that Dale's 

Ok, so the code in question is in addition to the existing driver from the
mips guys and works with it ? I had the impression that it was a separate
driver development or something.

> patch(es) have been accepted and are queued to go into the mainline tree 
> at some point.

Ok. Do you know if Dale's patches are available separatedly while they are not
yet in mainline, so Nicolas Det can work on them and make sure they also work
on the Pegasos board, which is not an embedded board but from the chrp
lineage. Nicolas already did some mv643xx ethernet driver work last summer,
but apparently had trouble integrating this in the mainline kernel, and it
seems his work has now been redone by Dale or something. Do you know who the
right person to communicate with about this would be ? The MIPS folk didn't
reply to any of our mails about this subject.

> Did I answer your question?

I think so. I was just surprised to see this 64x6x work go to arch/ppc instead
to drivers/net. I haven't really looked at the code though. Nicolas could you
comment on this ? 

Friendly,

Sven Luther
> 
> Mark
> 
> 
