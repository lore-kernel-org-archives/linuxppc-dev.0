Return-Path: <kenneth@southpole.se>
Received: from mail.southpole.se (mail.southpole.se [193.12.106.18])
	by ozlabs.org (Postfix) with ESMTP id 8BE2DB7BCC
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 28 Oct 2009 20:56:49 +1100 (EST)
Subject: RE: Accessing flash directly from User Space
From: Kenneth Johansson <kenneth@southpole.se>
To: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
In-Reply-To: <BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<4AE7545F.80805@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D366B6@midas.usurf.usu.edu>
	<4AE75859.5050108@billgatliff.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D3688B@midas.usurf.usu.edu>
	<4AE774ED.8050502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368AA@midas.usurf.usu.edu>
	<4AE7775D.8080502@freescale.com>
	<BB99A6BA28709744BF22A68E6D7EB51F0330D368E3@midas.usurf.usu.edu>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 28 Oct 2009 10:56:45 +0100
Message-Id: <1256723805.32158.241.camel@kenjo-laptop>
Mime-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Bill Gatliff <bgat@billgatliff.com>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2009-10-27 at 16:52 -0600, Jonathan Haws wrote:
> > Jonathan Haws wrote:
> > > I had thought about using MTD, but decided against it because with
> > > previous benchmarking that we did with MTD and our custom driver,
> > we
> > > found that our custom driver was about 10x faster.
> > 
> > Ouch.  Any idea where the slowdown is coming from?
> 
> From what I remember (I would have to dig up notes to make sure) it is something to do with MTD looking for a signal to go high that is processed a bunch before MTD even sees it.  Our flash produces a hardware ready signal that we are triggering off of to move on.  MTD took much longer to report to us that the hardware was ready.
> 
> Thanks
> 

It would be interesting to know in more detail what is was. If we have a
10x performance increase hiding from for us I would be very interested
in knowing where it is.

Are you using some custom command to the flash that the generic chip
drivers in Linux is not yet supporting ?
