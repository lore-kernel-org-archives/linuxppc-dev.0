Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id C57BA67AA9
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 26 Mar 2005 09:13:16 +1100 (EST)
Date: Fri, 25 Mar 2005 17:11:34 -0500 (EST)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <3787fed579cbb8849677a0baa10e0ee4@embeddededge.com>
Message-ID: <Pine.LNX.4.61.0503251707250.16955@localhost.localdomain>
References: <Pine.LNX.4.61.0503251617100.15647@localhost.localdomain>
	<3787fed579cbb8849677a0baa10e0ee4@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: still not clear on which tree to be using these days
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Fri, 25 Mar 2005, Dan Malek wrote:

>
> On Mar 25, 2005, at 4:19 PM, Robert P. J. Day wrote:
>
> >   what is the proper tree to be using these days for a 2.6 kernel
> > on 8xx?  for the longest time, i've used the "bk" checkout from
> > bkbits.net, but i see others now working with what looks like the
> > latest stock 2.6.x release.
>
> I just use the latest kernel.org tree for everything.  If I'm
> submitting a patch, or working with someone else, I use the bk tree
> just to be that little more up to date.

i just downloaded the 2.6.11-5 kernel source and was a bit nonplussed
to discover that "8xx" wasn't in the list of choices for processor,
until i noticed in the Kconfig file that 8xx depends on "BROKEN".  oh,
my. :-)  live and learn.

rday
