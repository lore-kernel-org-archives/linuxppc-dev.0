Return-Path: <jwboyer@gmail.com>
Date: Thu, 3 Jan 2008 10:01:31 -0600
From: Josh Boyer <jwboyer@gmail.com>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH] powerpc: #address-cells & #size-cells properties not
	inherited
Message-ID: <20080103100131.5b1c64b8@zod.rchland.ibm.com>
In-Reply-To: <20080103153256.GA18716@mag.az.mvista.com>
References: <20080103000750.GA22035@mag.az.mvista.com>
	<20080102194640.48c97d0c@vader.jdub.homelinux.org>
	<20080103153256.GA18716@mag.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, David Gibson <dgibson@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 3 Jan 2008 08:32:56 -0700
"Mark A. Greer" <mgreer@mvista.com> wrote:

> On Wed, Jan 02, 2008 at 07:46:40PM -0600, Josh Boyer wrote:
> > On Wed, 2 Jan 2008 17:07:50 -0700
> > "Mark A. Greer" <mgreer@mvista.com> wrote:
> > 
> > > From: Mark A. Greer <mgreer@mvista.com>
> > > 
> > > Fix error in booting-without-of.txt that indicates that a node can inherit
> > > its #address-cells and #size-cells definitions from its parent's parent.
> > > This is not correct and the latest dtc enforces it.
> > 
> > I'm lazy so I haven't checked myself, but by "latest dtc" does that
> > mean the DTC that's in the kernel now?
> > 
> > Things are going to be fun when we start saying generic things like
> > "latest DTC".  And when upstream DTC gets new features or enforcements,
> > we'll have to have all the in-kernel DTS files patched up when that
> > version of DTC gets merged in-kernel.  Just something to keep in mind
> > as we move along.
> 
> Yeah, I thought about that last night, actually.
> I think I'll just change that sentence to "This is not correct."
> 
> Avoid the issue :)

Lazy!  I like it ;)

josh
