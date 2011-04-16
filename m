Return-Path: <acrux_it@libero.it>
Received: from cp-out11.libero.it (cp-out11.libero.it [212.52.84.111])
	by ozlabs.org (Postfix) with ESMTP id 405921007D7
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 16 Apr 2011 10:33:54 +1000 (EST)
Date: Sat, 16 Apr 2011 02:33:46 +0200
From: acrux <acrux_it@libero.it>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: PowerMacintosh B&W G3 boot failure - linux-2.6.36.x
Message-Id: <20110416023346.03bb75fe.acrux_it@libero.it>
In-Reply-To: <1302749356.28876.105.camel@pasglop>
References: <20110413202714.ad1b5697.acrux_it@libero.it>
	<1302749356.28876.105.camel@pasglop>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 14 Apr 2011 12:49:16 +1000
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:


> What video driver are you trying to use ? Have you tried plain offb ?
> (disabling whatever is the native driver for your video card, ie,
> radeonfb or aty128fb or even atyfb, dunno what you have in there).
> 
> You can also try something like "udbg-immortal" on the kernel command
> line see if that brings you more debug output.
> 

i asked for more tests and it seems  "udbg-immortal" maybe helped.
Here a new screenshot:
http://cruxppc.org/~acrux/DSC_0002_modified.jpg
and the bootkernel (config was attached in the previus mail) was
compiled with CONFIG_SMP=y 

my regards,
--nico
-- 
GNU/Linux on Power Architecture
CRUX PPC - http://cruxppc.org/
