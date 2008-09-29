Return-Path: <scottwood@freescale.com>
Date: Mon, 29 Sep 2008 15:18:30 -0500
From: Scott Wood <scottwood@freescale.com>
To: Jon Smirl <jonsmirl@gmail.com>
Subject: Re: USB support on mpc5200 broken
Message-ID: <20080929201829.GA16153@ld0162-tx32.am.freescale.net>
References: <9e4733910809241451x7492d2a9s56b4cb4ee0fe0244@mail.gmail.com>
	<9e4733910809241809r58bddc2ax4759b70c3f07f6cf@mail.gmail.com>
	<1222307447.8277.147.camel@pasglop>
	<48E02FD0.8000809@genesi-usa.com>
	<20080929034329.GB8694@yookeroo.seuss>
	<9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <9e4733910809290714td2dc6cclecf2e2b080a80ca1@mail.gmail.com>
Cc: David Gibson <david@gibson.dropbear.id.au>,
	linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Sep 29, 2008 at 10:14:18AM -0400, Jon Smirl wrote:
> Shouldn't the driver already know it is being used on a BE machine?

No.  Endianness of the CPU is not necessarily the same as the endianness
of device registers.

For example, PCI OHCI on a big-endian host.

-Scott
