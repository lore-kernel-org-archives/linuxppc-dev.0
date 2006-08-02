Return-Path: <trini@kernel.crashing.org>
Date: Wed, 2 Aug 2006 11:15:14 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
Subject: Re: [PATCH 5/6] bootwrapper: Add support for the DINK firmware
Message-ID: <20060802181514.GO3075@smtp.west.cox.net>
References: <20060719231421.GF3887@mag.az.mvista.com>
	<20060802161934.GI3075@smtp.west.cox.net>
	<20060802181422.GG17652@mag.az.mvista.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060802181422.GG17652@mag.az.mvista.com>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Aug 02, 2006 at 11:14:22AM -0700, Mark A. Greer wrote:
> On Wed, Aug 02, 2006 at 09:19:34AM -0700, Tom Rini wrote:
> > On Wed, Jul 19, 2006 at 04:14:21PM -0700, Mark A. Greer wrote:
> > 
> > > This patch adds the firmware operations that support the DINK firmware
> > > from Freescale.
> > 
> > This isn't really DINK support (which would mean actually talking
> > back/with DINK,
> 
> You seem to be thinking that this is the final, end-all solution to
> everything.  It isn't.  Its a step in the direction that we are trying
> go (IIUC).  dink.c is about the easiest one there will be.  of.c has a
> slightly more complicated fw_ops.  We still need to figure out what uboot
> needs and what PIBS needs and what...

Right.  I'm just saying that unless you're planning on making this talk
with / use DINK (I swear, the DINK manual talks about this a bit, but
I'm too lazy to look just this second), this isn't the DINK one, this is
the (will be needed and used) bare metal one.

-- 
Tom Rini
