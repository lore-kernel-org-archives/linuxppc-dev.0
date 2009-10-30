Return-Path: <Jonathan.Haws@sdl.usu.edu>
Received: from kronos.usurf.usu.edu (kronos.usurf.usu.edu [129.123.194.129])
	by ozlabs.org (Postfix) with ESMTP id 69F56B7C34
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 31 Oct 2009 01:57:20 +1100 (EST)
From: Jonathan Haws <Jonathan.Haws@sdl.usu.edu>
To: Michael Buesch <mb@bu3sch.de>, "linuxppc-dev@lists.ozlabs.org"
	<linuxppc-dev@lists.ozlabs.org>
Date: Fri, 30 Oct 2009 08:57:12 -0600
Subject: RE: Accessing flash directly from User Space [SOLVED]
Message-ID: <BB99A6BA28709744BF22A68E6D7EB51F0330E23124@midas.usurf.usu.edu>
References: <BB99A6BA28709744BF22A68E6D7EB51F0330D3666C@midas.usurf.usu.edu>
	<20091029233038.GA21587@b07421-ec1.am.freescale.net>
	<BB99A6BA28709744BF22A68E6D7EB51F0330E230FC@midas.usurf.usu.edu>
	<200910301556.11349.mb@bu3sch.de>
In-Reply-To: <200910301556.11349.mb@bu3sch.de>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Cc: Scott Wood <scottwood@freescale.com>, Bill Gatliff <bgat@billgatliff.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

> On Friday 30 October 2009 15:50:22 Jonathan Haws wrote:
> > > I suspect that the msync() was merely serving as a very
> heavyweight
> > > memory barrier.
> >
> > I did try hacking the mb() calls from the kernel source to use
> them in user space, but they had no effect.  I still had to include
> the calls to msync().
>=20
> What did the resulting mb() that you used look like?

asm("eieio; sync");
