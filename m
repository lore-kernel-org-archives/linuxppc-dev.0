Return-Path: <stern+4d41317e@rowland.harvard.edu>
Received: from iolanthe.rowland.org (iolanthe.rowland.org [192.131.102.54])
	by ozlabs.org (Postfix) with SMTP id 0DBBDB710C
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 02:36:35 +1100 (EST)
Date: Mon, 7 Feb 2011 10:36:31 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
In-Reply-To: <20110207152132.GM10564@opensource.wolfsonmicro.com>
Message-ID: <Pine.LNX.4.44L0.1102071035320.1924-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-embedded@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
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

On Mon, 7 Feb 2011, Mark Brown wrote:

> On Tue, Feb 08, 2011 at 02:19:16AM +1100, Stephen Rothwell wrote:
> 
> > At least some of the powerpc defconfigs were added with CONFIG_PM
> > disabled.  I assume that was on purpose (though it may not have been).
> 
> I'd not be so sure - since it's a bool without an explicit default set
> Kconfig will default to disabling it and if anything enabling it is the
> option that requires special effort.

This may be a naive suggestion, but have you considered simply _asking_
the people who added those defconfigs?

Alan Stern
