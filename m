Return-Path: <sammy@sammy.net>
Date: Wed, 7 Oct 2009 09:52:43 -0400
From: Sam Creasey <sammy@sammy.net>
To: Julian Calaby <julian.calaby@gmail.com>
Subject: Re: [RFC PATCH 00/12] Merge common OpenFirmware device tree code
Message-ID: <20091007135243.GC21646@anhedonia>
References: <20091007041007.16890.62194.stgit@angua>
	<fa686aa40910062149p5d7141e4x3ff849fd4d191f38@mail.gmail.com>
	<646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <646765f40910062218s19d540f9q14c9086bedd1d9da@mail.gmail.com>
Cc: Sam Creasey <sammy@sammy.net>, Stephen Rothwell <sfr@canb.auug.org.au>,
	monstr@monstr.eu, devicetree-discuss@lists.ozlabs.org,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 07, 2009 at 03:18:04PM +1000, Julian Calaby wrote:
> On Wed, Oct 7, 2009 at 14:49, Grant Likely <grant.likely@secretlab.ca> wrote:
> > On Tue, Oct 6, 2009 at 10:29 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> >>
> >> So here goes.  I've begun the work to merge and clean up the OF device
> >> tree handling code and this is my first set of patches.  Not fully
> >> tested yet, but I'm getting them out to the lists so that I can start
> >> responding to comments and collecting acks.  This first batch isn't
> >> anything exciting, just a merge of common code
> 
> Good work, for what it's worth, this all looks good to me.
> 
> > However, I've completely devoted to this work for at least the next
> > two months, so there are plenty more patches to follow.  Once I've
> > got all the common code merged between Microblaze, PowerPC and Sparc
> > I'll be fix the endian problems and making it easily usable by other
> > architectures like ARM and MIPS.  Lots of work to be done.
> 
> On the subject of merging code, I know that the SUN3 code in m68k uses
> a similar prom interface to the sparc32 code. (and I've also
> considered unifying that and ... well ... see above) Does anyone know
> if it has an OpenFirmware interface for it's devices? Is OF on SUN3
> even remotely useful? Does Linux on SUN3 even work with modern
> kernels?

Sun3 doesn't have OF, though I've got some dormant patches to add an
OF emulation layer to make it easier to reuse Sparc drivers on
Sun3...   Never finished enough to submit, so it probably shouldn't
affect anything you're doing here.

As for recent kernels, I think 2.6.19 was the last sun3 I distributed
patches for, so modern might be pushing it...

-- Sam
