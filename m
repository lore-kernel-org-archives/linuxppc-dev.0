Return-Path: <mgreer@mvista.com>
Date: Wed, 2 Aug 2006 11:14:22 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Subject: Re: [PATCH 5/6] bootwrapper: Add support for the DINK firmware
Message-ID: <20060802181422.GG17652@mag.az.mvista.com>
References: <20060719231421.GF3887@mag.az.mvista.com>
	<20060802161934.GI3075@smtp.west.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060802161934.GI3075@smtp.west.cox.net>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 09:19:34AM -0700, Tom Rini wrote:
> On Wed, Jul 19, 2006 at 04:14:21PM -0700, Mark A. Greer wrote:
> 
> > This patch adds the firmware operations that support the DINK firmware
> > from Freescale.
> 
> This isn't really DINK support (which would mean actually talking
> back/with DINK,

You seem to be thinking that this is the final, end-all solution to
everything.  It isn't.  Its a step in the direction that we are trying
go (IIUC).  dink.c is about the easiest one there will be.  of.c has a
slightly more complicated fw_ops.  We still need to figure out what uboot
needs and what PIBS needs and what...

As things are added, it'll evolve.

> parsing the infos that it does pass along, and it does,
> iirc,

Not that I know of.

> but I don't recall if it's at all ever correct / useful :)) but
> just a, um, I suck at naming things (see arch/ppc/boot/simple) but
> non-nonsense, no help 'firmware' ops.  Please think up a name that
> doesn't suck (as a name I would come up with would).  Thanks!

Guess I suck too b/c I can't think of anything better.  As things
evolve, fw_ops may go away all together.  The problem is, I'm not
exactly sure where we're going to end up so this is the best that
I can do with the info that I have.

Mark
