Return-Path: <richardcochran@gmail.com>
Date: Sat, 19 Mar 2011 11:14:12 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
Message-ID: <20110319101412.GA14207@riccoc20.at.omicron.at>
References: <cover.1298878618.git.richard.cochran@omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1298878618.git.richard.cochran@omicron.at>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>,
	Paul Mackerras <paulus@samba.org>, John Stultz <john.stultz@linaro.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

For all those interested in the user space aspect, I have posted some
patches to ptpd project showing how the API works.

https://sourceforge.net/tracker/?group_id=139814&atid=744634

3225599 [PATCH 1/3] Convert to POSIX clock API.
3225603 [PATCH 2/3] Adapted to use the Linux PTP Hardware Clock API.
3225607 [PATCH 3/3] Adapted to use the newer SO_TIMESTAMPING Linux API.

Enjoy,

Richard
