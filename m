Return-Path: <richardcochran@gmail.com>
Date: Wed, 16 Mar 2011 15:26:03 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V12 0/4] ptp: IEEE 1588 hardware clock support
Message-ID: <20110316142603.GC12435@riccoc20.at.omicron.at>
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

On Mon, Feb 28, 2011 at 08:57:03AM +0100, Richard Cochran wrote:
> * PHC Patch ChangeLog
> ** v12
> *** gianfar_ptp
>    - fixed up device tree
>    - inlined the header file
>    - use platform_ calls instead of deprecated of_ calls
>    - removed static global single instance
>    - removed John Stultz's ack from this patch

@Thomas and John:

Can I get your acks on the remaining patches?

Can this be merged for 2.6.39?

Thanks,

Richard
