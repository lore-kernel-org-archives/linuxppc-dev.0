Return-Path: <trini@kernel.crashing.org>
Date: Mon, 10 Jan 2005 09:44:02 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Christoph Hellwig <hch@lst.de>
Message-ID: <20050110164402.GF2226@smtp.west.cox.net>
References: <4240b916050109074053e328b1@mail.gmail.com>
	<16865.39960.274092.996530@cargo.ozlabs.ibm.com>
	<20050110145219.GB2226@smtp.west.cox.net>
	<20050110163914.GA11906@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050110163914.GA11906@lst.de>
Cc: Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, linuxppc64-dev@ozlabs.org
Subject: Re: Classic PPC specific ASM (CONFIG_6XX)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 10, 2005 at 05:39:15PM +0100, Christoph Hellwig wrote:
> On Mon, Jan 10, 2005 at 07:52:19AM -0700, Tom Rini wrote:
> > +# PPC_PREP can be set to y on a PPC970 configuration, which isn't a real
> > +# machine.
> 
> Maybe we should prevent setting PPC_PREP to y for PPC970 instead?

I don't know if that'll compile.  It'd be nice because it means we could
try splitting the PREP stuff out of the OpenFirmware (pmac/chrp) stuff
again.

-- 
Tom Rini
http://gate.crashing.org/~trini/
