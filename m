Return-Path: <jonsmirl@gmail.com>
Message-ID: <9e4733910712101304s23aa02b0o1be2ed9856ea1f8d@mail.gmail.com>
Date: Mon, 10 Dec 2007 16:04:22 -0500
From: "Jon Smirl" <jonsmirl@gmail.com>
To: "Grant Likely" <grant.likely@secretlab.ca>
Subject: Re: ppc vs powerpc
In-Reply-To: <fa686aa40712101259h22be4b89ke4f36564a7c1866c@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <9e4733910712101254r1bf8925o20ee6eacd3af6a18@mail.gmail.com>
	<fa686aa40712101259h22be4b89ke4f36564a7c1866c@mail.gmail.com>
Cc: PowerPC dev list <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On 12/10/07, Grant Likely <grant.likely@secretlab.ca> wrote:
> On 12/10/07, Jon Smirl <jonsmirl@gmail.com> wrote:
> > Is the plan for ppc to be completely merged with powerpc and then be
> > eliminated? If so, how close is this to completion?
> >
> > What should we do with ppc users of mpc-i2c? If the plan is to
> > eliminate ppc I would say to just copy the existing driver and then
> > delete the old version when the rest of ppc gets deleted.
>
> arch/ppc is scheduled to be removed middle of 2008.  Don't break
> arch/ppc users before then.  Ideally there should be overlap between
> the addition of support in arch/powerpc and the removal of support
> from arch/ppc.
>
> Personally, I structure the driver to support both platform bus and
> of_platform bus.  It's not hard to do and it keeps things
> understandable.  Take a look at drivers/block/xsysace for an example.

I can look at it but I'm not enthused about writing new code to
support something that is scheduled to be deleted in six months. It
would be much simpler to just copy the old driver. I'm spending way
too much time on what I thought was a fairly simple change.

>
> Cheers,
> g.
>
>
> --
> Grant Likely, B.Sc., P.Eng.
> Secret Lab Technologies Ltd.
> grant.likely@secretlab.ca
> (403) 399-0195
>


-- 
Jon Smirl
jonsmirl@gmail.com
