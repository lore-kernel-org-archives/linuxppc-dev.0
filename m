Return-Path: <michael@ellerman.id.au>
Date: Mon, 5 Aug 2013 12:21:21 +1000
From: Michael Ellerman <michael@ellerman.id.au>
To: Fionnuala Gunter <fin@linux.vnet.ibm.com>
Subject: Re: [PATCH] drivers/crypto/nx: saves chaining value from co-processor
Message-ID: <20130805022120.GA5281@concordia>
References: <1375477090.32477.10.camel@what-is-leg>
 <1375477741.15999.23.camel@pasglop>
 <1375480550.32477.19.camel@what-is-leg>
 <1375480754.15999.42.camel@pasglop>
 <1375481816.32477.22.camel@what-is-leg>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1375481816.32477.22.camel@what-is-leg>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 02, 2013 at 05:16:56PM -0500, Fionnuala Gunter wrote:
> On Sat, 2013-08-03 at 07:59 +1000, Benjamin Herrenschmidt wrote:
> > On Fri, 2013-08-02 at 16:55 -0500, Fionnuala Gunter wrote:
> > > Sorry, I thought linuxppc-dev was the right tree since the patch is
> > > for
> > > a ppc driver and you've carried previous nx driver submissions
> > > upstream. 
> > > 
> > > I want to submit to the proper place, so what is your preference?
> > 
> > Well, that's the right place if you want me to merge it, which seems to
> > be what Marcelo is also expecting...
> 
> Please merge this patch, it fixes a hot bug.

You don't actually mention that anywhere in the changelog.

The description implies that it's probably a bug, but doesn't describe
the symptoms in any way - does it make it completely non-functional or
just break in certain corner cases.

And you make no mention of when this bug appeared, has it always been
there, or was it introduced by a particular commit? That's important
because it helps determine whether the patch should go into any of the
stable trees.

cheers
