Date: Mon, 12 Aug 2002 15:54:27 +1000
From: David Gibson <david@gibson.dropbear.id.au>
To: akuster <akuster@dslextreme.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: First steps to OCP device model integration
Message-ID: <20020812055427.GX23642@zax>
References: <20020809042605.GC23642@zax> <3D541AE9.40007@dslextreme.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3D541AE9.40007@dslextreme.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Aug 09, 2002 at 12:41:29PM -0700, akuster wrote:
>
> David Gibson wrote:
> >THe patch below implements the first steps in transitioning the
> >handling of 4xx OCP devices to the unfied device model (in 2.5).  So
> >far the code just registers an ocp bus and registers each device
> >described in core_ocp on that bus.  The next step is to convert the
> >actual device drivers so that that they register with the unified
> >driver tree rather than through the old ocp_register() mechanism.
> >
> >I will commit this shortly unless there are serious objections.
>
> I object seriously.
>
>  Some of what you have might be useful.:) OCP is not just for 4xx.
In

Sure, details, changing names is easy.  At the moment 4xx is the only
thing using OCP so we might as well get it working for that before
worrying too much about anything else.

> fact the name may need to change.  I have been working on overhalling
> this interface and testing the ideas before having a review of the
> changes.  I am on the hook to Paul and others to get this out in the
> open to discuss and am not ready.  So if you could just relax and
> wait I

So how about you tell us about this new scheme of yours.  This is not
a difficult problem, and you've been making intermittent mutterings
for months.

> would appriciate it.  I would rather see the 2.5 kernel boot on a few
> 4xx boards

OCP support is currently the main thing lacking for that.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
