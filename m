Return-Path: <broonie@sirena.org.uk>
Received: from cassiel.sirena.org.uk (unknown [IPv6:2001:41c8:1:5384::2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC7DEB7105
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Aug 2011 10:14:53 +1000 (EST)
Date: Tue, 2 Aug 2011 00:46:45 +0100
From: Mark Brown <broonie@opensource.wolfsonmicro.com>
To: Timur Tabi <timur@freescale.com>
Subject: Re: [PATCH] drivers/misc: introduce Freescale Data Collection
	Manager driver
Message-ID: <20110801234645.GA15792@sirena.org.uk>
References: <1312235334-15036-1-git-send-email-timur@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1312235334-15036-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org, arnd@arndb.de
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 01, 2011 at 04:48:54PM -0500, Timur Tabi wrote:
> The Data Collection Manager (DCM) is a feature of the FPGA on some Freescale
> PowerPC reference boards that can read temperature, current, and voltage
> settings from the sensors on those boards.  This driver exposes the DCM via a
> sysfs interface (/sys/devices/platform/fsl-ocm.0).

This sounds like it should be a hwmon driver.

> The DCM collects and tallies data over a period of time in the background,
> without utilizing any resources on the host (CPU, memory, etc).  The data is
> summarized and made available when data collection stops.  This allows power
> consumption to be measured while the host is performing some tasks (usually
> a benchmark).

Though this is a bit odd for the subsystem I don't think it's too far
out of what other hwmon chips can do, some of them do have longer term
stats than just instantaneous readings.
