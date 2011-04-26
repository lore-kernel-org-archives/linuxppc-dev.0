Return-Path: <Hans-Christian.Egtvedt@atmel.com>
Received: from sjogate2.atmel.com (newsmtp5.atmel.com [204.2.163.5])
	by ozlabs.org (Postfix) with ESMTP id 89A38B6F15
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 26 Apr 2011 23:23:01 +1000 (EST)
Subject: Re: [PATCH 11/14] PM / AVR32: Use struct syscore_ops instead of
	sysdevs for PM
From: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
In-Reply-To: <201104172313.09712.rjw@sisk.pl>
References: <201103280125.11750.rjw@sisk.pl>
	<201104172301.54115.rjw@sisk.pl>  <201104172313.09712.rjw@sisk.pl>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 26 Apr 2011 14:22:12 +0200
Message-ID: <1303820532.3125.12.camel@hcegtvedt>
Mime-Version: 1.0
Cc: Kevin Hilman <khilman@ti.com>, Guan Xuetao <gxt@mprc.pku.edu.cn>,
	Russell King <linux@arm.linux.org.uk>,
	Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>,
	Greg KH <gregkh@suse.de>, LKML <linux-kernel@vger.kernel.org>,
	Ralf Baechle <ralf@linux-mips.org>,
	Jeremy Fitzhardinge <jeremy.fitzhardinge@citrix.com>,
	Ben Dooks <ben-linux@fluff.org>, Jiri Kosina <jkosina@suse.cz>,
	Kay Sievers <kay.sievers@suse.de>, Mike Frysinger <vapier@gentoo.org>,
	Linux PM mailing list <linux-pm@lists.linux-foundation.org>,
	linux-omap@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-04-17 at 23:13 +0200, Rafael J. Wysocki wrote:
> From: Rafael J. Wysocki <rjw@sisk.pl>
> 
> Convert some AVR32 architecture's code to using struct syscore_ops
> objects for power management instead of sysdev classes and sysdevs.
> 
> This simplifies the code and reduces the kernel's memory footprint.
> It also is necessary for removing sysdevs from the kernel entirely in
> the future.
> 
> Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

Acked-by: Hans-Christian Egtvedt <hans-christian.egtvedt@atmel.com>

Thanks, nice work. Tested and run on hardware.

<snipp>

-- 
Hans-Christian Egtvedt
