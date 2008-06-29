Return-Path: <glikely@secretlab.ca>
Received: from qb-out-0506.google.com (qb-out-0506.google.com [72.14.204.235])
	by ozlabs.org (Postfix) with ESMTP id 3C5D9DDF24
	for <linuxppc-dev@ozlabs.org>; Sun, 29 Jun 2008 15:50:06 +1000 (EST)
Received: by qb-out-0506.google.com with SMTP id d8so2683129qbc.37
	for <linuxppc-dev@ozlabs.org>; Sat, 28 Jun 2008 22:50:05 -0700 (PDT)
Date: Sat, 28 Jun 2008 23:50:02 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] [RFC] powerpc: Xilinx: adding virtex5 powerpc 440 support
Message-ID: <20080629055002.GG13876@secretlab.ca>
References: <20080623162856.D5FA41CA806C@mail66-dub.bigfish.com>
	<20080623150846.40d65f08@zod.rchland.ibm.com>
	<20080623213038.490C110B806B@mail11-dub.bigfish.com>
	<20080623213556.3378316a@zod.rchland.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080623213556.3378316a@zod.rchland.ibm.com>
Sender: Grant Likely <glikely@secretlab.ca>
Cc: linuxppc-dev@ozlabs.org, John Linn <John.Linn@xilinx.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jun 23, 2008 at 09:35:56PM -0400, Josh Boyer wrote:
> On Mon, 23 Jun 2008 15:30:35 -0600 John Linn <John.Linn@xilinx.com> wrote:
> > I'll try to better understand if we can detect the compressed device
> > tree and if we really have to disable the APU.
> > 
> > What's the reasoning for being independent of the kernel, maybe it's
> > obvious to everyone but me?
> 
> The intention, as I understand it, is that the wrapper utilities can be
> installed stand-alone and used to wrap other kernels if needs be.  In
> practice I've not seen this happen yet, as most PowerPC kernels
> are built directly from the kernel source.  Fedora does have a
> separate package for the wrapper bits, but I'm not entirely sure it's
> used.
> 
> My understanding could be totally wrong, and if so I'll politely ask
> Paul or anyone else to hit me with a cluebat :).

AFAIK, the reason is to be able to build multiple bootwrapper
configurations around a single kernel image without multiple compiles of
the wrapper bits, and to increase the amount of compile testing that all
the wrapper bits are subjected to.  (this way they get compiled on all
PowerPC kernel compiles instead of just when they are needed for an
obscure platform)

g.
