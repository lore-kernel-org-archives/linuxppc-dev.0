Return-Path: <richardcochran@gmail.com>
Date: Fri, 24 Sep 2010 09:55:34 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] posix clocks: introduce a syscall for clock tuning.
Message-ID: <20100924075534.GB5043@riccoc20.at.omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
	<1285279423.5158.20.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1285279423.5158.20.camel@pasglop>
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	Rodolfo Giometti <giometti@linux.it>, Christoph Lameter <cl@linux.com>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 24, 2010 at 08:03:43AM +1000, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-23 at 19:31 +0200, Richard Cochran wrote:
> > A new syscall is introduced that allows tuning of a POSIX clock. The
> > syscall is implemented for four architectures: arm, blackfin, powerpc,
> > and x86.
> > 
> > The new syscall, clock_adjtime, takes two parameters, the clock ID,
> > and a pointer to a struct timex. The semantics of the timex struct
> > have been expanded by one additional mode flag, which allows an
> > absolute offset correction. When specificied, the clock offset is
> > immediately corrected by adding the given time value to the current
> > time value.
> 
> Any reason why you CC'ed device-tree discuss ?
> 
> This list is getting way too much unrelated stuff, which I find
> annoying, it would be nice if we were all a bit more careful here with
> our CC lists.

Sorry, I only added device-tree because some one asked me to do so.

    http://marc.info/?l=linux-netdev&m=127273157912358

I'll leave it off next time.

Thanks,
Richard
