Return-Path: <dgibson@ozlabs.org>
Date: Tue, 16 Oct 2007 13:24:15 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Refactor booting-without-of.txt
Message-ID: <20071016032415.GO26787@localhost.localdomain>
References: <fa686aa40710150908o55d1f5d2t264cbb8ed800a12f@mail.gmail.com>
	<20071015165505.GA16040@lixom.net>
	<fa686aa40710151014q5e151ea9w3f589d9e89e95905@mail.gmail.com>
	<20071016023845.GK26787@localhost.localdomain>
	<fa686aa40710152002l5bb2c746i8174827e8d66c746@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <fa686aa40710152002l5bb2c746i8174827e8d66c746@mail.gmail.com>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev <linuxppc-dev@ozlabs.org>,
	microblaze-uclinux@itee.uq.edu.au
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Oct 15, 2007 at 09:02:09PM -0600, Grant Likely wrote:
> On 10/15/07, David Gibson <david@gibson.dropbear.id.au> wrote:
> > On Mon, Oct 15, 2007 at 11:14:44AM -0600, Grant Likely wrote:
> > > On 10/15/07, Olof Johansson <olof@lixom.net> wrote:
> > > > On Mon, Oct 15, 2007 at 10:08:44AM -0600, Grant Likely wrote:
> > > > > Adding the Linux expected device tree bindings to
> > > > > booting-without-of.txt seems to be getting a little unwieldy.  Plus
> > > > > with more than one arch using the device tree (powerpc, sparc &
> > > > > microblaze) the device tree bindings aren't necessarily powerpc only
> > > > > (the Xilinx devices certainly fall in this category).
> > > > >
> > > > > Anyone have comments about splitting the expected device tree bindings
> > > > > out of booting-without-of.txt into a separate directory?
> > > >
> > > > The flat device tree is, in spite of what some people would like it to be,
> > > > not open firmware, nor is it the same as their bindings. So I think we'd
> > > > be doing ourselves a disservice by continuing to associate them together.
> > > > All it would take is a rename of the directory, unfortunately i don't
> > > > have any suggestions on better names though.
> > >
> > > I think I need to stick with the of prefix.  All the support API in
> > > include/linux/of_* is prefixed with "of_" already, so convention is
> > > established.
> > >
> > > How about Documentation/of-device-tree?
> >
> > It seems a little counterintuitive to change names from "booting
> > *without* of" to "of *"...
> 
> Heh; true.  The *only* reason I think it should be 'of-<anything>' is
> because *all* the support APIs are named that way.  I'll happily use

No, not all, just most...

And do bear in mind that a lot of those accessor functions are at
least valid both on of and flat-tree systems.

> another name if I get the impression that most of us in our little
> group think it should be something else.
> 
> Cheers,
> g.
> 
> 

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
