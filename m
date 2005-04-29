Return-Path: <trini@kernel.crashing.org>
Date: Fri, 29 Apr 2005 10:57:04 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: David Woodhouse <dwmw2@infradead.org>
Message-ID: <20050429175704.GI1221@smtp.west.cox.net>
References: <20050428153733.GD1221@smtp.west.cox.net>
	<1114796691.27227.224.camel@hades.cambridge.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1114796691.27227.224.camel@hades.cambridge.redhat.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
Subject: Re: rsync mirrors of linuxppc-* on source.mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, Apr 29, 2005 at 06:44:50PM +0100, David Woodhouse wrote:
> On Thu, 2005-04-28 at 08:37 -0700, Tom Rini wrote:
> > With the shift away from BitKeeper, and with PowerPC work having long
> > shifted away from the linuxppc-* bitkeeper trees and towards a more
> > direct relationship with Andrew / et al, is there any value in keeping
> > the rsync mirrors of the last state of the linuxppc-* trees available?
> > 
> > As there's no metadata, my slant is towards no.  But it wouldn't be hard
> > to have these still exist, if people speak up.
> 
> You could just convert them to git format?

The linuxppc-* trees?  They really aren't useful nowadays.  Maybe the
linuxppc-2.4 tree should be, assuming Marcelo switches to git, and
there's some desire to continue the practice of letting work that's done
vs 2.4 exist somewhere in the community and added to.

But for 2.6, thankfully, folks are either using quilt (or similar) to
track their own work, or a project-specific tree, which I fully expect
to become git trees.  I think we can finally kill the notion of a
'master' PPC tree that's not Linus' tree, via Andrew's tree.

-- 
Tom Rini
http://gate.crashing.org/~trini/
