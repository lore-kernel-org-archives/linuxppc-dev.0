Return-Path: <g.liakhovetski@gmx.de>
Received: from mail.gmx.net (mail.gmx.de [213.165.64.20])
	by ozlabs.org (Postfix) with SMTP id BC4DD67C75
	for <linuxppc-dev@ozlabs.org>; Wed,  4 Oct 2006 06:58:23 +1000 (EST)
Date: Tue, 3 Oct 2006 22:58:28 +0200 (CEST)
From: Guennadi Liakhovetski <g.liakhovetski@gmx.de>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: Undefined '.bus_to_virt', '.virt_to_bus' causes compile error
	on Powerpc 64-bit
In-Reply-To: <20061002234428.GE3278@stusta.de>
Message-ID: <Pine.LNX.4.60.0610032236510.3937@poirot.grange>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, Judith Lebzelter <judith@osdl.org>,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 3 Oct 2006, Adrian Bunk wrote:

> On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:
> 
> > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> 
> known for ages - the drivers need fixing.

...

> > WARNING: ".bus_to_virt" [drivers/scsi/tmscsim.ko] undefined!

The problem with this one is that the code path, where bus_to_virt is 
used, is only executed under some very exotic circumstances, i.e., 
is practically untestable. I'll try to cook something up for that...

Thanks
Guennadi
---
Guennadi Liakhovetski
