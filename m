Date: Mon, 23 Aug 1999 16:27:46 -0400 (EDT)
From: Tom Rini <trini@disparity.net>
To: brad allison <jackal@aol.net>
cc: rshaw@inficad.com, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org, puetzk@iastate.edu
Subject: Re: BootX enhancement request
In-Reply-To: <Pine.SGI.4.00.9908231613030.7470-100000@osiris.office.aol.com>
Message-ID: <Pine.BSF.3.96.990823162311.86405K-100000@silver.teardrop.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Aug 1999, brad allison wrote:

> On Mon, 23 Aug 1999, Robert Shaw wrote:
> 
> > Brad,
> > 
> > Once again, you DO NOT NEED TO DO THIS! The B&W G3 now has video support.

This, BETA, driver. :)

> I think you missed my point.  Don't get me wrong, that's cool to know.
> But I was thinking more along the lines of a drop down menu to set the
> resolution from BootX rather than cryptic kernel arguements.

So you want BootX to be able to do what Monitors & Sound can do.  Either
pick a mode there and use BootX from MacOS, or once 2.4.0 rolls around,
specify video=aty128fb:1024x768@75 (or so).  There is no need for BootX to
do this.

> It seems the 2.2.10 kernel will not sync to the video settings at all
> without the kernel arguements.

What, aty128fb?  It's beta and not done.  You're prolly better off using
No Video Driver, unles you're gonna play w/ the source (Anthony, speak up
if i'm wrong). :)

> > The FAQ page at my site (http://www.inficad.com/~rshaw/g3_faq.shtml) 
> > also has the
> > reproduction of the vmode settings that are available. They work, and
> > no running of Xautoconfig is needed.
> 
> Well i think putting Xautoconfig in the rc.local file is still a good
> idea.

Xautoconfig is nice for monitors that don't work right w/ Xconfigurator.
It's not a tool for "No Video Driver" machines, it's a tool for wierd
monitors/easier to setup X.

---
Tom Rini (TR1265)
http://gate.crashing.org/~trini/


[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
