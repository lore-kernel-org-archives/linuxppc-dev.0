Return-Path: <rjw@sisk.pl>
Received: from ogre.sisk.pl (ogre.sisk.pl [217.79.144.158])
	by ozlabs.org (Postfix) with ESMTP id EF21CB7120
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 06:40:35 +1100 (EST)
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Date: Mon, 7 Feb 2011 20:16:53 +0100
References: <20110207152132.GM10564@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1102071035320.1924-100000@iolanthe.rowland.org>
	<20110207154953.GN10564@opensource.wolfsonmicro.com>
In-Reply-To: <20110207154953.GN10564@opensource.wolfsonmicro.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-1"
Message-Id: <201102072016.53410.rjw@sisk.pl>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-embedded@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>, linux-kernel@vger.kernel.org,
	Alan Stern <stern@rowland.harvard.edu>,
	Geert Uytterhoeven <geert@linux-m68k.org>,
	linux-pm@lists.linux-foundation.org,
	ppc-dev <linuxppc-dev@lists.ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Monday, February 07, 2011, Mark Brown wrote:
> On Mon, Feb 07, 2011 at 10:36:31AM -0500, Alan Stern wrote:
> > On Mon, 7 Feb 2011, Mark Brown wrote:
> 
> > > I'd not be so sure - since it's a bool without an explicit default set
> > > Kconfig will default to disabling it and if anything enabling it is the
> > > option that requires special effort.
> 
> > This may be a naive suggestion, but have you considered simply _asking_
> > the people who added those defconfigs?
> 
> I'm rather hoping that they'll notice the mailing list thread or that
> someone else who knows what's going on with them does - as Geert pointed
> out there's a considerable number of defconfigs that have this turned
> off.  It seems more sensible to get some idea if this seems sane to
> people in the general case before going trying to identify and contact
> so many individuals.
> 
> If there are systems that really require disabling CONFIG_PM we probably
> need to add stuff to Kconfig to make sure it can't be enabled anyway;
> this shouldn't enable any new configurations.

Well, as I've just said, I don't like this change.  I'd very much prefer it if
CONFIG_PM_OPS were renamed to CONFIG_PM.

Thanks,
Rafael
