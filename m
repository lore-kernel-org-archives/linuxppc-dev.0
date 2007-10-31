Return-Path: <dgibson@ozlabs.org>
Date: Wed, 31 Oct 2007 13:56:13 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Josh Boyer <jwboyer@gmail.com>
Subject: Re: [PATCH 2/4] PowerPC: 440GRx Rainier DTS.
Message-ID: <20071031025613.GC7772@localhost.localdomain>
References: <20071030164511.GA21973@ru.mvista.com>
	<20071030165650.GA22107@ru.mvista.com>
	<20071030230805.GC2784@localhost.localdomain>
	<20071031015651.GB19318@lixom.net>
	<20071030210917.42cfb88b@vader.jdub.homelinux.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071030210917.42cfb88b@vader.jdub.homelinux.org>
Cc: Olof Johansson <olof@lixom.net>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 30, 2007 at 09:09:17PM -0500, Josh Boyer wrote:
> On Tue, 30 Oct 2007 20:56:51 -0500
> Olof Johansson <olof@lixom.net> wrote:
> 
> > On Wed, Oct 31, 2007 at 10:08:05AM +1100, David Gibson wrote:
> > > On Tue, Oct 30, 2007 at 07:56:50PM +0300, Valentine Barshak wrote:
> > > > PowerPC 440GRx Rainier DTS.
> > > [snip]
> > > > +		SDRAM0: sdram {
> > > > +			device_type = "memory-controller";
> > > 
> > > How many times do we need to say it...
> > > 
> > > Don't make up random device_type values.  This does not belong here.
> > 
> > Maybe there should be something like checkpatch.pl that warns about
> > these kinds of things so people can check for it without getting flamed
> > first. :-)

I'd be gentler; except that I know Valentine has been active on this
list recently, so has almost certainly seen similar comments before.

> That's actually a decent idea.  We could even have this thing that
> takes DTS files and processes them...  oh wait.
> 
> So why can't we make a whitelist of "allowed" device_types in DTC and
> make it whine about anything outside of that?

Well, that sort of thing is the idea for dtc to check, when it has
checks enabled anyway.  Getting it so that it doesn't have too many
false positives is the tricky bit, as we've seen with some of the
existing checks (where "too many" is "almost any").

Patches welcome...

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
