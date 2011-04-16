Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id CE4FF1007D1
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 10:52:29 +1000 (EST)
Subject: Re: PowerMacintosh B&W G3 boot failure - linux-2.6.36.x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: acrux <acrux_it@libero.it>
In-Reply-To: <20110416023346.03bb75fe.acrux_it@libero.it>
References: <20110413202714.ad1b5697.acrux_it@libero.it>
	<1302749356.28876.105.camel@pasglop>
	<20110416023346.03bb75fe.acrux_it@libero.it>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 16 Apr 2011 10:52:18 +1000
Message-ID: <1302915138.28876.143.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2011-04-16 at 02:33 +0200, acrux wrote:
> On Thu, 14 Apr 2011 12:49:16 +1000
> Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
> 
> 
> > What video driver are you trying to use ? Have you tried plain offb ?
> > (disabling whatever is the native driver for your video card, ie,
> > radeonfb or aty128fb or even atyfb, dunno what you have in there).
> > 
> > You can also try something like "udbg-immortal" on the kernel command
> > line see if that brings you more debug output.
> > 
> 
> i asked for more tests and it seems  "udbg-immortal" maybe helped.
> Here a new screenshot:
> http://cruxppc.org/~acrux/DSC_0002_modified.jpg
> and the bootkernel (config was attached in the previus mail) was
> compiled with CONFIG_SMP=y 

Does the problem happens if you compile it without CONFIG_SMP ?

Cheers,
Ben.
