Return-Path: <david-b@pacbell.net>
Received: from smtp107.sbc.mail.mud.yahoo.com (smtp107.sbc.mail.mud.yahoo.com
	[68.142.198.206]) by ozlabs.org (Postfix) with SMTP id 0A39067B59
	for <linuxppc-dev@ozlabs.org>; Wed,  2 Aug 2006 02:21:26 +1000 (EST)
From: David Brownell <david-b@pacbell.net>
To: linux-usb-devel@lists.sourceforge.net
Subject: Re: [linux-usb-devel] [PATCH] Add USB to MPC8349 PB platform support
Date: Tue, 1 Aug 2006 08:36:02 -0700
References: <4879B0C6C249214CBE7AB04453F84E4D050B55@zch01exm20.fsl.freescale.net>
	<1E6652B1-3126-4B69-BE9D-8DCE8DCACE7C@embeddedalley.com>
	<a0bc9bf80607191159l679ce8ddm35a30236a9d887c7@mail.gmail.com>
In-Reply-To: <a0bc9bf80607191159l679ce8ddm35a30236a9d887c7@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Message-Id: <200608010836.03511.david-b@pacbell.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 19 July 2006 11:59 am, Li Yang wrote:
> On 7/19/06, Dan Malek <dan@embeddedalley.com> wrote:
> >
> > On Jul 19, 2006, at 9:14 AM, Kumar Gala wrote:
> >
> > > This is an incorrect assumption.  Its more often that people dont
> > > post their ports to the Linux kernel for acceptance.  We will
> > > accept any port that is willing to work with the community.   for
> > > example
> >
> > I agree.  The customers of board ports I've done over the years
> > are always eager to get these into the public sources.  It just
> > seems we run out of time during the pressure of trying to get
> > the products done, and they just issue them on CDs or for
> > download afterward.
> 
> But why?

Because the notion of a "board port" of a driver is usually bogus;
as a rule, a driver doesn't need board-specific knowledge, any
board using the same chip could work the same.  (And probably should;
most of the time I've seen board-specfic knowledge in drivers, it's
been masking bugs.)

And once the driver for a chip is open sourced, it can be reused
on other boards, generalized, and bugfixed ... none of which is
going to happen if you don't push the driver upstream.  That means
the second or third product using that chip (or its cousins) could
become more robust, faster, easier to use, and otherwise "better".

No matter how good your developers are, there will be bugs in the
code they produce.  Pushing drivers upstream increases the pool
of developers who _could_ fix the bugs and otherwise improve the
code, given time and incentive.


> Most embedded products facing end-user wouldn't like users 
> to modify the system by themselves.  Sometimes they even put effort in
> preventing user to do so.  If no one else is going to modify the code,
> what is the value of putting them in public sources?  Just to show the
> compliance with GPL?  The only kind of products I can think of, which
> want the users to modify the code is reference boards, IMHO.  Please
> correct me if I'm wrong.

OK, you're wrong.  :)

Because the "user" in this case is more like "other developers" than
dumb "end users" ... though you need to keep in mind that the "Free" in
"Free Software" refers to people being able to change from "end users"
to "developers" in the inevitable cases where an original developer
doesn't have time for basics like bug fixing older software, or adding
essential capabilities that somehow got overlooked in the original
rush to market.

And yes, that is sometimes contrary to the goals of some folk who
build embedded products.  It's the usual tradeoff of whether the
product goal is to solve end user problems or make money for some
vendor.  Wearing my end user hat, the answer is clear.

- Dave
