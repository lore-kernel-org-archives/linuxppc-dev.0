Return-Path: <richardcochran@gmail.com>
Date: Mon, 18 Apr 2011 10:06:07 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH V14 3/4] ptp: Added a clock driver for the IXP46x.
Message-ID: <20110418080606.GA3809@riccoc20.at.omicron.at>
References: <cover.1303107532.git.richard.cochran@omicron.at>
	<dbee2487a57fd7f41e4efbbd2ddfb1313b8d71bc.1303107532.git.richard.cochran@omicron.at>
	<201104180856.04186.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201104180856.04186.arnd@arndb.de>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
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

On Mon, Apr 18, 2011 at 08:56:03AM +0200, Arnd Bergmann wrote:
> On Monday 18 April 2011, Richard Cochran wrote:
> > +
> > +       lo = __raw_readl(&regs->channel[ch].src_uuid_lo);
> > +       hi = __raw_readl(&regs->channel[ch].src_uuid_hi);
> > +
> 
> I guess you should use readl(), not __raw_readl() here. The __raw_* functions
> are not meant for device drivers.

Krzysztof had a different opinion about this.

    https://lkml.org/lkml/2011/1/8/67

Anyway, it is his driver, and I just followed what he does elsewhere
in the driver. It make sense to me to keep the driver consistent.
Maybe we should make the change throughout?

Thanks,
Richard
