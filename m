Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp5.wanadoo.fr (smtp5.wanadoo.fr [193.252.22.26])
	by ozlabs.org (Postfix) with ESMTP id 673276861D
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 21 Oct 2005 01:50:25 +1000 (EST)
Received: from me-wanadoo.net (localhost [127.0.0.1])
	by mwinf0509.wanadoo.fr (SMTP Server) with ESMTP id A73DF1C002AA
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 20 Oct 2005 17:50:22 +0200 (CEST)
Date: Thu, 20 Oct 2005 17:37:30 +0200
To: "Mark A. Greer" <mgreer@mvista.com>
Message-ID: <20051020153730.GB28839@localhost.localdomain>
References: <ec55b17e0510130042m6c6c0c43ndf09f40a03f9cf97@mail.gmail.com>
	<20051013182654.GA18497@mag.az.mvista.com>
	<20051020150450.GA27704@localhost.localdomain>
	<20051020152157.GB18972@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20051020152157.GB18972@mag.az.mvista.com>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: MPC7447A based board with MV64462 Marvell Discovery III
	controller
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, Oct 20, 2005 at 08:21:57AM -0700, Mark A. Greer wrote:
> On Thu, Oct 20, 2005 at 05:04:50PM +0200, Sven Luther wrote:
> > Hey, we have code to boot the Freeserv with chrp/Of, need to clean it up and
> > merge it though. Would this be a good thing to submit for mainline inclusion,
> > it is a couple of lines at most, altough there is some reuse of the interrupt
> > controller code i think, which needs some cleanup.
> 
> I don't know what a "Freeserv" is but, sure, push it on up once you're
> happy with it.  The more code the merrier.  :)

It is also known as HPC1, which is the discovery III based freesscale
reference design, as the HPC2 is the tundra based one.

Friendly,

Sven Luther
