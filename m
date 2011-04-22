Return-Path: <richardcochran@gmail.com>
Date: Fri, 22 Apr 2011 11:21:59 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Ben Hutchings <bhutchings@solarflare.com>
Subject: Re: [PATCH V14 4/4] ptp: Added a clock driver for the National
	Semiconductor PHYTER.
Message-ID: <20110422092159.GA18708@riccoc20.at.omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<1728ffb5735c2a04876a69ad55427c4e7b5a1bd7.1303107532.git.richard.cochran@omicron.at>
	<1303160245.2857.60.camel@bwh-desktop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1303160245.2857.60.camel@bwh-desktop>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	Russell King <linux@arm.linux.org.uk>, Paul Mackerras <paulus@samba.org>,
	John Stultz <john.stultz@linaro.org>,
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

On Mon, Apr 18, 2011 at 09:57:25PM +0100, Ben Hutchings wrote:
> Would be better without the magic numbers.

Yes, of course, you are right, and also about patch #3.
Please take a look at v15 and see if it improves things.

Thanks,

Richard
