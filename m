Return-Path: <richardcochran@gmail.com>
Date: Fri, 25 Feb 2011 08:53:20 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found
	on the MPC85xx.
Message-ID: <20110225075320.GA4032@riccoc20.at.omicron.at>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110223132444.65dfdda4@schlenkerla>
	<20110224165004.GB15234@riccoc20.at.omicron.at>
	<20110224112731.2d9bf080@schlenkerla>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110224112731.2d9bf080@schlenkerla>
Cc: John Stultz <john.stultz@linaro.org>, Christoph Lameter <cl@linux.com>,
	Russell King <linux@arm.linux.org.uk>,
	Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, David Miller <davem@davemloft.net>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 24, 2011 at 11:27:31AM -0600, Scott Wood wrote:

> My vote, if it goes in a separate node at all, is "fsl,etsec-ptp",

So, that is what the patch does.

> and let the driver use SVR.

What is SVR?

Thanks,
Richard
