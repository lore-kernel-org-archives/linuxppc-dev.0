Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 3BF3C2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 14 Oct 2004 05:47:54 +1000 (EST)
Date: Wed, 13 Oct 2004 15:40:55 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Eugene Surovegin <ebs@ebshome.net>
In-Reply-To: <20041013193423.GA28349@gate.ebshome.net>
Message-ID: <Pine.LNX.4.60.0410131539150.23288@localhost.localdomain>
References: <Pine.LNX.4.60.0410131423540.12426@localhost.localdomain>
	<20041013193423.GA28349@gate.ebshome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: "I2C" versus "IIC"
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wed, 13 Oct 2004, Eugene Surovegin wrote:

> On Wed, Oct 13, 2004 at 02:26:23PM -0400, Robert P. J. Day wrote:
> >
> >   i was just about to rename some of my variables and macros to be
> > consistent with what i *thought* was the standard nomenclature of
> > "IIC" as opposed to "I2C".  just checked include/asm-ppc, and grepped
> > for case-insensitive instances of both strings ... oh, god.  there's
> > really no preferred usage, is there?
>
> Philips' documentation uses I2C, not IIC, so I guess this is
> _official_ name of the _bus_.
>
> Some vendors (like IBM in their 4xx parts) use IIC to name I2C
> _interface_ to distinguish it from I2C _bus_ (they specifically
> mention this in the chip manual).
>
> For example, in the corresponding 4xx driver I used "iic" because it
> was written for IBM IIC _interface_.

i'm starting to regret having brought this up. :-)  initially, i
thought it was going to involve only my deciding what i wanted to name
my own variables, to be consistent with common usage.  now i see that
it's nowhere near that straightforward.

i'm going to leave this to wiser heads to mull over.

rday
