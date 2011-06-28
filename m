Return-Path: <paubert@iram.es>
Received: from gra-lx1.iram.es (gra-lx1.iram.es [150.214.224.41])
	by ozlabs.org (Postfix) with ESMTP id 7C71BB6F67
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Jun 2011 22:51:52 +1000 (EST)
Date: Tue, 28 Jun 2011 14:51:48 +0200
From: Gabriel Paubert <paubert@iram.es>
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: Bug#630845: linux-image-2.6.39-2-powerpc: CHRP Pegasos2 boot
	failure
Message-ID: <20110628125148.GA10884@iram.es>
References: <20110617222943.2188.34712.reportbug@chrp.ab.bgc.com.au>
	<1308545397.11457.107.camel@localhost>
	<20110620222812.6cd7e862.andrewb@zagam.net>
	<1308711698.3093.285.camel@localhost>
	<20110623203654.04f151e1.andrewb@zagam.net>
	<1309126453.3093.1555.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1309126453.3093.1555.camel@localhost>
Cc: Michael Ellerman <michael@ellerman.id.au>, 630845@bugs.debian.org,
	linuxppc-dev@lists.ozlabs.org, Andrew Buckeridge <andrewb@zagam.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 26, 2011 at 11:14:13PM +0100, Ben Hutchings wrote:
> On Thu, 2011-06-23 at 20:36 +0800, Andrew Buckeridge wrote:
> > Package: linux-image-3.0.0-rc3-powerpc
> > Version: 3.0.0~rc3-1~experimental.1
> > 
> > On Wed, 22 Jun 2011 04:01:38 +0100
> > Ben Hutchings <ben@decadent.org.uk> wrote:
> > 
> > > > linux-image-2.6.36-trunk-powerpc_2.6.36-1~experimental.1_powerpc.deb
> > > > linux-image-2.6.37-1-powerpc_2.6.37-1_powerpc.deb
> > > > linux-image-2.6.37-2-powerpc_2.6.37-2_powerpc.deb
> > > > These failed to boot. In all cases stuck at the spinner.
> > > 
> > > At a guess, this may be fixed by a change in Linux 3.0-rc1:
> > 
> > > Please can you test Linux 3.0-rc3, currently available in experimental?
> > 
> > linux-image-3.0.0-rc3-powerpc_3.0.0~rc3-1~experimental.1_powerpc.deb
> > Also failed to boot and got stuck at spinner.
> 
> Gabriel, Michael, do you recognise this bug?  Are there any fixes for
> Pegasos that are missing from 3.0-rc3?

What do you mean by the spinner? I've had very long boot times with 
an apparently dead machine depending on graphics options.

For now I'm running 2.6.39 with one patch for keyboard/mouse handling
which is now upstream.

I can try a more recent kernel on Thursday.

	Gabriel
