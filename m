Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A1E60B6F1E
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 22:18:37 +1100 (EST)
Date: Tue, 8 Feb 2011 11:18:27 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Ray Lee <ray-lk@madrabbit.org>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Message-ID: <20110208111827.GA29850@opensource.wolfsonmicro.com>
References: <20110207152132.GM10564@opensource.wolfsonmicro.com>
	<Pine.LNX.4.44L0.1102071035320.1924-100000@iolanthe.rowland.org>
	<20110207154953.GN10564@opensource.wolfsonmicro.com>
	<AANLkTimh=8pSmQ6i-5H5+agSso7dCOcOrUJ6Uq_fu7nh@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <AANLkTimh=8pSmQ6i-5H5+agSso7dCOcOrUJ6Uq_fu7nh@mail.gmail.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-embedded@vger.kernel.org,
	Len Brown <len.brown@intel.com>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
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

On Mon, Feb 07, 2011 at 05:17:59PM -0800, Ray Lee wrote:
> On Mon, Feb 7, 2011 at 7:49 AM, Mark Brown

> > I'm rather hoping that they'll notice the mailing list thread or that
> > someone else who knows what's going on with them does

> Surely you're joking. I mean, do _you_ scan every message that comes
> through lkml and its various sister lists?

Actually I do at least scan most of the lists.

> Do a git blame and add them to the CC:. It's the polite thing to do.

It's also going to result in the mail not going to the mailing lists as
there's a limit on the number of people you can CC enforced by vger
which probably isn't constructive.  It's moot now but as I said in the
text you've helpfully cut I'd have suggested contacting them after the
thread had come to a conclusion.
