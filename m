Return-Path: <sven.luther@wanadoo.fr>
Received: from smtp7.wanadoo.fr (smtp7.wanadoo.fr [193.252.22.24])
	by ozlabs.org (Postfix) with ESMTP id 39C342BF16
	for <linuxppc-dev@ozlabs.org>; Mon, 10 Jan 2005 17:45:04 +1100 (EST)
Date: Mon, 10 Jan 2005 07:54:46 +0100
To: Sebastian Heutling <sheutlin@gmx.de>
Message-ID: <20050110065446.GA22998@pegasos>
References: <200412261435.13562.marc.dietrich@ap.physik.uni-giessen.de>
	<200501051733.06350.marvin24@gmx.de>
	<20050105165551.GA29287@pegasos>
	<200501052157.25302.marvin24@gmx.de> <41E1BBA2.30008@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <41E1BBA2.30008@gmx.de>
From: Sven Luther <sven.luther@wanadoo.fr>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [FYI] linux 2.6 still not working with PReP (ppc32)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2005 at 12:17:54AM +0100, Sebastian Heutling wrote:
> Marc Dietrich wrote:
> 
> >Hi all,
> >
> >I didn't recognise that the kernel from Sebastian - which was working fine 
> >here - was build from the debian sources (no hint in the kernel version). 
> >So I build everything again from debian source and fixed the irq's in 
> >prep_pci.c.
> > 
> >
> Erm ... well ... yes - it's a debian kernel ;).

Mmm, partman-prep was accepted, so it will make it to unstable tomorrow. It is
strange though since it worked on Cajus power4 ibm box, but not on my
powerstack. I am still investigating this, but the fix should happen quicker
now.

Friendly,

Sven Luther
