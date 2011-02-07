Return-Path: <broonie@opensource.wolfsonmicro.com>
Received: from opensource2.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C2A32B7123
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  8 Feb 2011 01:28:03 +1100 (EST)
Date: Mon, 7 Feb 2011 14:18:29 +0000
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] PM: Hide CONFIG_PM from users
Message-ID: <20110207141829.GK10564@opensource.wolfsonmicro.com>
References: <1297081335-13631-1-git-send-email-broonie@opensource.wolfsonmicro.com>
	<20110208011324.d5371c4c.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110208011324.d5371c4c.sfr@canb.auug.org.au>
Cc: Len Brown <len.brown@intel.com>, linux-embedded@vger.kernel.org,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	linux-kernel@vger.kernel.org, "Rafael J. Wysocki" <rjw@sisk.pl>,
	Alan Stern <stern@rowland.harvard.edu>,
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

On Tue, Feb 08, 2011 at 01:13:24AM +1100, Stephen Rothwell wrote:
> On Mon,  7 Feb 2011 12:22:15 +0000 Mark Brown <broonie@opensource.wolfsonmicro.com> wrote:

> > +	bool
> > +	default y if !IA64_HP_SIM

> Several powerpc configs have CONFIG_PM (implicitly) disabled (e.g. the
> server configs), so this will unexpectedly turn it on for them.

Do you mean that these systems require CONFIG_PM be turned off, or just
that people tend not to turn it on?  If the latter would you expect any
ill effects from doing so?
