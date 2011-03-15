Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 00401B6FD2
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Mar 2011 02:42:53 +1100 (EST)
Subject: Re: [PATCH] [v2] watchdog: booke_wdt: clean up status messages
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1297208386-15010-1-git-send-email-timur@freescale.com>
Date: Tue, 15 Mar 2011 10:42:42 -0500
Message-Id: <C8B1E427-5A9D-4ED2-9C39-C1D8201E636E@kernel.crashing.org>
References: <1297208386-15010-1-git-send-email-timur@freescale.com>
To: Timur Tabi <timur@freescale.com>
Cc: wim@iguana.be, linux-watchdog@vger.kernel.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Feb 8, 2011, at 5:39 PM, Timur Tabi wrote:

> Improve the status messages that are displayed during some operations =
of the
> PowerPC watchdog timer driver.  When the watchdog is enabled, the =
timeout is
> displayed as a number of seconds, instead of an obscure "period".  The =
"period"
> is the position of a bit in a 64-bit timer register.  The higher the =
value,
> the quicker the watchdog timeout occurs.  Some people chose a high =
"period"
> value for the timer and get confused as to why the board resets within =
a
> few seconds.
>=20
> Messages displayed during open and close are now debug messages, so =
that they
> don't clutter the console by default.  Finally, printk() is replaced =
with the
> pr_xxx() equivalent.
>=20
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> drivers/watchdog/booke_wdt.c |   19 +++++++++----------
> 1 files changed, 9 insertions(+), 10 deletions(-)

applied

- k=
