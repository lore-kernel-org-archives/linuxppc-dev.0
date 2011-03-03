Return-Path: <davem@davemloft.net>
Date: Thu, 03 Mar 2011 12:13:43 -0800 (PST)
Message-Id: <20110303.121343.28802720.davem@davemloft.net>
To: richardcochran@gmail.com
Subject: Re: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
From: David Miller <davem@davemloft.net>
In-Reply-To: <cover.1298878618.git.richard.cochran@omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: giometti@linux.it, arnd@arndb.de, peterz@infradead.org,
	linux-api@vger.kernel.org, devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, linux@arm.linux.org.uk,
	paulus@samba.org, john.stultz@linaro.org,
	alan@lxorguk.ukuu.org.uk, netdev@vger.kernel.org,
	vapier@gentoo.org, cl@linux.com, linuxppc-dev@lists.ozlabs.org,
	tglx@linutronix.de, linux-arm-kernel@lists.infradead.org, khc@pm.waw.pl
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Richard Cochran <richardcochran@gmail.com>
Date: Mon, 28 Feb 2011 08:57:03 +0100

> This really might be the last review of the PTP hardware clock patch
> series. These patches apply on top of the timers/core branch in the
> tip tree.

I'm find with the networking portions so:

Acked-by: David S. Miller <davem@davemloft.net>

I am assuming these will be pushed through the timers/core branch
since there are dependencies.

Thanks.
