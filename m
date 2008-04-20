Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 0F9D5DDFD4
	for <linuxppc-dev@ozlabs.org>; Sun, 20 Apr 2008 22:55:56 +1000 (EST)
From: Gabriel Paubert <paubert@iram.es>
Date: Sun, 20 Apr 2008 14:55:50 +0200
To: Paul Mackerras <paulus@samba.org>
Subject: Re: removal of arch/ppc in 2.6.27?
Message-ID: <20080420125550.GA1286@iram.es>
References: <D713F373-AE2A-4341-9C29-EF65B9399B36@kernel.crashing.org>
	<200804201314.47311.marvin24@gmx.de>
	<18443.13999.770734.826892@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <18443.13999.770734.826892@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, Apr 20, 2008 at 10:27:27PM +1000, Paul Mackerras wrote:
> Marvin writes:
> 
> > will this be the end of life for all the PReP's ? I remember a patch posted 
> > some month ago, but didn't heard anything since then. Any news? Or just let 
> > it die quietly?
> 
> No, I'm still planning on getting PReP support over to arch/powerpc,
> but getting time to work on it has been the difficulty.
> 
> What sort of PReP do you have?

On my side, I have MVME2[467]xx boards. But these are actually PPLUS
board but the residual data and boot methods are so similar to PreP
that they could be merged. The host bridge is flexible (the MVME5100
has the same PHB but a completely different layout set up by the
firmware IIRC). I have local patches in the tree I use (still 2.2)
that make the memory map more CHRP like (to have more PCI memory
space and less I/O space).

The main problem is that I'm short on cycles to work on porting
them to 2.6 (the other is that I'm not sure that it's worth
putting 2.6 on machines with 16MB of RAM, current kernels
with extremely stripped down configs are still much  larger
than the ones I run on these boards).

	Gabriel
