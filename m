Return-Path: <mgreer@mvista.com>
Date: Tue, 26 Jun 2007 10:18:11 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [CURIOUSITY] When will we stop caring about arch/ppc?
Message-ID: <20070626171811.GD31457@mag.az.mvista.com>
References: <20070625182304.GC31840@mag.az.mvista.com>
	<1182796800.23775.51.camel@weaponx.rchland.ibm.com>
	<0FBD8D7C-1A60-4305-992C-5C28ECE41278@kernel.crashing.org>
	<1182804609.20939.5.camel@weaponx.rchland.ibm.com>
	<b75c4d9610522f1a45ed1e65c9a4a548@kernel.crashing.org>
	<1182864764.19501.7.camel@weaponx.rchland.ibm.com>
	<1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1ce7f225511ea3d67a63b8a4ac683e0c@kernel.crashing.org>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Jun 26, 2007 at 03:46:58PM +0200, Segher Boessenkool wrote:
> >>> But I meant adding
> >>> something in the Documentation/powerpc/ directory and maybe
> >>> feature-removal-schedule.txt.  Basically a written down thing in the
> >>> kernel source to refer people to.
> >>
> >> How about this time next year -- special event at
> >> the OLS PowerPC BOF :-)
> >
> > Heh, sounds good to me.
> >
> > Of course, getting stuff done in a year.... ;)
> 
> Well the arch/ppc tree is basically frozen already, all Freescale
> stuff got moved over already as far as I can see, and 4xx has
> started moving.  I think a year is enough, since the tree is
> frozen anyway, people can resurrect stuff from older releases
> if need be, no problem with deleting it.  In fact, why not do
> so this year :-)  [Yeah that was a joke].

Actually, I wouldn't have a problem with getting rid of arch/ppc right
now.  It won't really be lost, just git checkout your favorite tag that
still has it.  It'll get rid of code people shouldn't be worrying about
anymore anyway.

I realize, I'm probably the only one with this opinion so you don't have
to tell me all the reasons I'm wrong. :)

Mark
