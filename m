Return-Path: <nmiell@comcast.net>
Received: from sccrmhc15.comcast.net (sccrmhc15.comcast.net [204.127.200.85])
	by ozlabs.org (Postfix) with ESMTP id A1EDB67BE3
	for <linuxppc-dev@ozlabs.org>; Tue,  3 Oct 2006 13:00:07 +1000 (EST)
Subject: Re: [2.6 patch] mark virt_to_bus/bus_to_virt as __deprecated on i386
From: Nicholas Miell <nmiell@comcast.net>
To: Adrian Bunk <bunk@stusta.de>
In-Reply-To: <20061003015820.GG3278@stusta.de>
References: <20061002214954.GD665@shell0.pdx.osdl.net>
	<20061002234428.GE3278@stusta.de> <20061003012241.GF3278@stusta.de>
	<1159840091.2349.0.camel@entropy>  <20061003015820.GG3278@stusta.de>
Content-Type: text/plain
Date: Mon, 02 Oct 2006 19:55:00 -0700
Message-Id: <1159844100.2349.5.camel@entropy>
Mime-Version: 1.0
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

On Tue, 2006-10-03 at 03:58 +0200, Adrian Bunk wrote:
> On Mon, Oct 02, 2006 at 06:48:11PM -0700, Nicholas Miell wrote:
> > On Tue, 2006-10-03 at 03:22 +0200, Adrian Bunk wrote:
> > > On Tue, Oct 03, 2006 at 01:44:28AM +0200, Adrian Bunk wrote:
> > > > On Mon, Oct 02, 2006 at 02:49:54PM -0700, Judith Lebzelter wrote:
> > > > 
> > > > > Hello:
> > > > 
> > > > Hi Judith,
> > > > 
> > > > > For the automated cross-compile builds at OSDL, powerpc 64-bit 
> > > > > 'allmodconfig' is failing.  The warnings/errors below appear in 
> > > > > the 'modpost' stage of kernel compiles for 2.6.18 and -mm2 kernels.
> > > > 
> > > > known for ages - the drivers need fixing.
> > > > 
> > > > You might want to convince Andrew accepting my patch to make 
> > > > virt_to_bus/bus_to_virt give compile warnings on i386 for making
> > > > people more aware of this problem...
> > > >...
> > > 
> > > In case anyone is interested, the patch is below.
> > > 
> > > cu
> > > Adrian
> > > 
> > 
> > Won't this also cause warnings for valid arch-specific usage (i.e. in
> > linux/arch/{i386,x86_64})?
> 
> They aren't used under linux/arch/i386/ and my patch doesn't change x86_64.

Sorry, for some reason I thought isa_bus_to_virt and isa_virt_to_bus
were defined in terms of virt_to_bus/bus_to_virt instead of
virt_to_phys/phys_to_virt.


-- 
Nicholas Miell <nmiell@comcast.net>
