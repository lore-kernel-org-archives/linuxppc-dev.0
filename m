Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] posix clocks: introduce a syscall for clock tuning.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <alpine.LFD.2.00.1009240008390.2416@localhost6.localdomain6>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
	<1285279423.5158.20.camel@pasglop>
	<alpine.LFD.2.00.1009240008390.2416@localhost6.localdomain6>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 24 Sep 2010 11:20:04 +1000
Message-ID: <1285291204.14081.8.camel@pasglop>
Mime-Version: 1.0
Cc: Peter Zijlstra <peterz@infradead.org>, John Stultz <johnstul@us.ibm.com>,
	Richard Cochran <richardcochran@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	LKML <linux-kernel@vger.kernel.org>,
	David Miller <davem@davemloft.net>, netdev@vger.kernel.org,
	linux-api@vger.kernel.org, Christoph Lameter <cl@linux.com>,
	Rodolfo Giometti <giometti@linux.it>, devicetree-discuss@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2010-09-24 at 00:12 +0200, Thomas Gleixner wrote:
> > This list is getting way too much unrelated stuff, which I find
> > annoying, it would be nice if we were all a bit more careful here
> with
> > our CC lists.
> 
> Says the guy who missed to trim the useless context of the original
> mail, which made me scroll down all the way just to find out that
> there is nothing to see. 

Heh, you can usually ignore what's after my signature :-) At least I
didn't put my reply all the way down the bottom !

Cheers,
Ben.
