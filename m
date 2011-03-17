Return-Path: <glikely@secretlab.ca>
Sender: Grant Likely <glikely@secretlab.ca>
Date: Thu, 17 Mar 2011 13:21:16 -0600
From: Grant Likely <grant.likely@secretlab.ca>
To: Richard Cochran <richardcochran@gmail.com>
Subject: Re: [PATCH V11 2/4] ptp: Added a clock that uses the eTSEC found on
	the MPC85xx.
Message-ID: <20110317192116.GC12824@angua.secretlab.ca>
References: <cover.1298447722.git.richard.cochran@omicron.at>
	<be1f5e801e8cd0145dd23aadae7c2055bb3c1d47.1298447722.git.richard.cochran@omicron.at>
	<20110223165058.GE14597@angua.secretlab.ca>
	<20110223112612.30071995@schlenkerla>
	<20110223175459.GH14597@angua.secretlab.ca>
	<20110223132444.65dfdda4@schlenkerla>
	<20110224165004.GB15234@riccoc20.at.omicron.at>
	<20110224112731.2d9bf080@schlenkerla>
	<20110225075320.GA4032@riccoc20.at.omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110225075320.GA4032@riccoc20.at.omicron.at>
Cc: John Stultz <john.stultz@linaro.org>, Christoph Lameter <cl@linux.com>,
	Russell King <linux@arm.linux.org.uk>,
	Rodolfo Giometti <giometti@linux.it>, Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
	Alan Cox <alan@lxorguk.ukuu.org.uk>, netdev@vger.kernel.org,
	Scott Wood <scottwood@freescale.com>, Mike Frysinger <vapier@gentoo.org>,
	Thomas Gleixner <tglx@linutronix.de>, linuxppc-dev@lists.ozlabs.org,
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

On Fri, Feb 25, 2011 at 08:53:20AM +0100, Richard Cochran wrote:
> On Thu, Feb 24, 2011 at 11:27:31AM -0600, Scott Wood wrote:
> 
> > My vote, if it goes in a separate node at all, is "fsl,etsec-ptp",
> 
> So, that is what the patch does.
> 
> > and let the driver use SVR.
> 
> What is SVR?

An on chip register that provides the exact version of the SoC.  (As
opposed to PVR which is the version of the cpu core).

g.
