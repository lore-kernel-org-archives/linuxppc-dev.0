Date: Mon, 18 Mar 2002 08:00:49 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Michael Sokolov <msokolov@ivan.Harhan.ORG>
Cc: linux-galileo@source.mvista.com, linuxppc-dev@lists.linuxppc.org
Subject: Re: [PATCH] My GT-64260 enhancements
Message-ID: <20020318150049.GC3762@opus.bloom.county>
References: <20020316151505.GA713@opus.bloom.county> <0203170703.AA00587@ivan.Harhan.ORG>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <0203170703.AA00587@ivan.Harhan.ORG>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Mar 16, 2002 at 11:03:13PM -0800, Michael Sokolov wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
>
> > Well, (and I do need to check out the _galileo tree) iirc the stuff to
> > support that option is in one of the generic files.  Or generic to the
> > work currently in there.  If that's the case, and you're explicitly not
> > going to support it in your files (and ports) then add a -a
> > "$CONFIG_xxx" = "n" .
>
> You still don't get it. I find that logic offensive. It makes me not want to
> use the GT-64260 in my designs because your logic implies that if someone uses
> the GT-64260 s/he wants to do things your way.

Yes, it assumes that if you're going to make a GT-64260 based port and
get it into the main tree you're going to use the common files for said
chipset so that all of the boards can be said to have certain things
working and reduce the ammount of coding needed to be done by you.

Like Troy said in an earlier message, it's great that you've got all of
this work done, but if you want to get it into the main tree and not
just keep up your own fork of it, some of your code will have to be
modified.  The current stuff has the feature that it can make use of
CONFIG_SERIAL_TEXT_DEBUG on all ports.

> Just because there is a generic file doesn't mean I'm obligated to use
> it in my ports.

Actually, unless you've got good and preferably technical objections to
it, you are.  Once it gets into the main trees, it's not just your board
port, it's everyones board port.  And duplication of code isn't
generally a good thing.

If you've done your GT-64260 board without duplicating most of the work
in gt64260_common.c, then we can add in tests for your board(s) or even
just define a CONFIG_STARMON and test for that.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
