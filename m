Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 514C7DDED0
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 17:44:49 +1000 (EST)
Date: Sun, 6 May 2007 11:44:29 +0400
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] [POWERPC] 8xx: mpc885ads pcmcia support
Message-ID: <20070506114429.5c631864@localhost.localdomain>
In-Reply-To: <67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
References: <20070506004737.31233.52611.stgit@localhost.localdomain>
	<67c6bf6b7d37f5e133398ea83edeac78@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linux-pcmcia@lists.infradead.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 6 May 2007 03:04:14 +0200
Segher Boessenkool wrote:

> > +		pcmcia@0080 {
> 
> > +			#interrupt-cells = <1>;
> 
> > +			interrupt-parent = <ff000000>;
> > +			interrupts = <d 1>;
> > +		};
> 
> Since this node's children's interrupt representation
> is different from the node's parent's, you need an
> interrupt-map in here.  You also forgot "#address-cells"
> and I think you need "ranges" too?
> 
Well, in fact it does not introduce SoC device different from any others
represented inside soc885 node. mk_int_int_mask() is just special
way of enabling irq for PCMCIA stuff, in addition to normal pic stuff.

Emm. Why would I need #address-cells and ranges here? it uses parent bus address space...

-- 
Sincerely, Vitaly
