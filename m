Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 0/7] [RFC] Xenon support
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
In-Reply-To: <1173301611.5799.38.camel@zod.rchland.ibm.com>
References: <20070307180144.812594000@elitedvb.net> >
	<1173301611.5799.38.camel@zod.rchland.ibm.com>
Content-Type: text/plain
Date: Thu, 08 Mar 2007 10:48:45 +0100
Message-Id: <1173347325.8635.18.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: Linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2007-03-07 at 15:06 -0600, Josh Boyer wrote:
> On Wed, 2007-03-07 at 19:01 +0100, Felix Domke wrote:
> > This series of patches add support for the Xbox 360 gaming console.
> > 
> > Note that these patches were written by different people, who want
> > to remain anonymous. These drivers were written without hardware 
> > documentation being available.
> 
> Taking anonymous contributions to the kernel goes against the
> Developer's Certificate of Origin.  Are you sure you can certify it's
> origin and are willing to take responsibility for the code?
> 
> Personally, I'd NAK this whole series.

The whole serie can't be merged anyway, the patches aren't in good
enough shape.

Regarding the legal status I think the serie can't be merged at least
not by any of the maintainer for the reason you mention.

What should happen at this stage is that somebody writes a documentation
of the hardware based on those patches and somebody else writes patches
based on that documentation.

The fact that the initial patches were posted publically make the
process a bit harder but still somewhat possible (if the final code is
obviously not inherited from the original one in any way).

Ben.
