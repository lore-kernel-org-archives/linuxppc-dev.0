Return-Path: <richardcochran@gmail.com>
Date: Thu, 19 Aug 2010 11:22:47 +0200
From: Richard Cochran <richardcochran@gmail.com>
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/5] ptp: Added a brand new class driver for ptp clocks.
Message-ID: <20100819092246.GA8484@riccoc20.at.omicron.at>
References: <cover.1281956490.git.richard.cochran@omicron.at>
	<201008171336.29375.arnd@arndb.de>
	<20100818140440.GA22655@riccoc20.at.omicron.at>
	<201008181702.03384.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <201008181702.03384.arnd@arndb.de>
Cc: Rodolfo Giometti <giometti@linux.it>, john stultz <johnstul@us.ibm.com>,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Aug 18, 2010 at 05:02:03PM +0200, Arnd Bergmann wrote:
> You might want to use callbacks for these system calls that you
> can register to at module load time, like it is done for the
> existing syscalls.

Can you point me to a specific example?

> The simpler way (e.g. for testing) is using Kconfig dependencies, like
> 
> config PTP
> 	bool "IEEE 1588 Precision Time Protocol"
> 
> config PPS
> 	tristate "Pulse per Second"
> 	depends on PTP || !PTP
> 
> The depends statement is a way of expressing that when PTP is enabled,
> PPS cannot be a module, while it may be a module if PTP is disabled.

THis did not work for me.

What I got was, in effect, two independent booleans.


Thanks,

Richard
