Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 84AB51007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 18 Apr 2011 16:02:15 +1000 (EST)
Date: Sun, 17 Apr 2011 23:02:18 -0700
From: Greg KH <gregkh@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Subject: Re: [PATCH 0/14] Remove sysdev suspend/resume and shutdown operations
Message-ID: <20110418060218.GB22168@suse.de>
References: <201103280125.11750.rjw@sisk.pl> <201104172301.54115.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201104172301.54115.rjw@sisk.pl>
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	LKML <linux-kernel@vger.kernel.org>, Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Apr 17, 2011 at 11:01:53PM +0200, Rafael J. Wysocki wrote:
> Hi,
> 
> The following series of patches fixes bugs related to the introduction
> of struct syscore_ops later in this cycle, replaces sysdev suspend/resume
> operations in all of the architectures still using them with struct
> syscore_ops-based PM callbacks and finally removes the suspend/resume
> and shutdown operations from struct sysdev_class and struct sysdev_driver.
> 
> Patches [1/14] and [2/14] are important bug fixes targeted at 2.6.39.
> The remaining patches are regareded as 2.6.40 material, but I'd like to
> put them into linux-next shortly, if there are no objections, to catch
> problems that they may introduce before they hit the mainline.  Again,
> if there are no objections I'd like to merge these patches through the
> suspend-2.6 tree.

No objection from me at all, thanks for doing this they look great.

Acked-by: Greg Kroah-Hartman <gregkh@suse.de>
