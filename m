Date: Thu, 5 Feb 2004 13:47:17 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Matt Porter <mporter@kernel.crashing.org>
Cc: eric lescouet <eric.lescouet@Jaluna.COM>,
	Michele.Pallaro@alcatel.it,
	linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Linux kernel and u-boot for mpc8540
Message-ID: <20040205134717.A17211@home.com>
References: <4021F487.660E680B@alcatel.it> <40220DC0.2050105@Jaluna.COM> <20040205091232.A15092@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20040205091232.A15092@home.com>; from mporter@kernel.crashing.org on Thu, Feb 05, 2004 at 09:12:32AM -0700
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Feb 05, 2004 at 09:12:32AM -0700, Matt Porter wrote:
>
> On Thu, Feb 05, 2004 at 10:32:48AM +0100, eric lescouet wrote:
> >
> > Michele,
> >
> > Support for mpc8540 is already in linuxppc-2.4 tree.
> > see ppc.bkbits.net
>
> Actually, the linuxppc-2.4 support is incomplete, there's no TSEC/FEC
> driver or other on-chip peripheral drivers in that tree to make it
> really useful. You could just use a PCI network card to nfsroot a
> filesystem and get started, though.

Ooops...gotta correct this before I confuse somebody.  The TSEC/FEC
gianfar driver is in the tree...I missed that changeset. :)

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
