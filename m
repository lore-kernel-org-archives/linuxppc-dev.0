Return-Path: <rob@landley.net>
Received: from grelber.thyrsus.com
	(static-71-162-243-5.phlapa.fios.verizon.net [71.162.243.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4B405DDE2F
	for <linuxppc-dev@ozlabs.org>; Sat, 12 May 2007 13:31:21 +1000 (EST)
From: Rob Landley <rob@landley.net>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: Building ppc/powerpc kernel to run under QEMU.
Date: Fri, 11 May 2007 23:30:01 -0400
References: <200705092203.26042.rob@landley.net> <464397B8.408@genesi-usa.com>
	<20070511014629.GA31705@localhost.localdomain>
In-Reply-To: <20070511014629.GA31705@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200705112330.02262.rob@landley.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thursday 10 May 2007 9:46 pm, David Gibson wrote:
> On Thu, May 10, 2007 at 11:07:52PM +0100, Matt Sealey wrote:
> > QEMU really really wants a PREP kernel, and that stuff's just not in the 
new
> > arch/powerpc tree anymore is it?
> 
> qemu is PReP, eh?  Well that would explain the not working: PReP
> hasn't been ported to arch/powerpc yet.  The fact that qemu acts like
> a PReP might make doing so rather easier.

It's slightly more compliated than that.

The CVS version of QEMU says it can emulate the following architectures:

qemu-system-ppc -M ?
Supported machines are:
g3bw       Heathrow based PowerMAC (default)
mac99      Mac99 based PowerMAC
prep       PowerPC PREP platform
ref405ep   ref405ep
taihu      taihu

Unfortunately, the powermac variants want a hard drive image (the open 
hackware bios won't finish booting without it), and the other two are new 
enough I haven't had a chance to try 'em yet.

The only way I've managed to build a prep kernel is ARCH=ppc.  I can build a 
CHRP kernel with arch=powerpc, but can't figure out how to tell qemu to boot 
it (and am told formatting a fake partitioned hard drive image is The Way).

Rob
