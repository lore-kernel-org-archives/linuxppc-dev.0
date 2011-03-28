Return-Path: <john.stultz@linaro.org>
Subject: Re: [PATCH V13 3/4] ptp: Added a clock driver for the IXP46x.
From: John Stultz <john.stultz@linaro.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <706adc379f5f64dfad665cb8f831f44050b59eae.1301206090.git.richard.cochran@omicron.at>
References: <cover.1301206090.git.richard.cochran@omicron.at>
	<706adc379f5f64dfad665cb8f831f44050b59eae.1301206090.git.richard.cochran@omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 28 Mar 2011 11:07:54 -0700
Message-ID: <1301335674.21829.2.camel@work-vm>
Mime-Version: 1.0
Cc: Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	Thomas Gleixner <tglx@linutronix.de>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2011-03-27 at 08:39 +0200, Richard Cochran wrote:
> This patch adds a driver for the hardware time stamping unit found on the
> IXP465. The basic clock operations and an external trigger are implemented.
> 
> Signed-off-by: Richard Cochran <richard.cochran@omicron.at>

Acked-by: John Stultz <john.stultz@linaro.org>
