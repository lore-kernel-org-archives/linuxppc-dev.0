Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] posix clocks: introduce a syscall for clock tuning.
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Richard Cochran <richardcochran@gmail.com>
In-Reply-To: <20100924075534.GB5043@riccoc20.at.omicron.at>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
	<1285279423.5158.20.camel@pasglop>
	<20100924075534.GB5043@riccoc20.at.omicron.at>
Content-Type: text/plain; charset="UTF-8"
Date: Sat, 25 Sep 2010 08:12:20 +1000
Message-ID: <1285366340.14081.34.camel@pasglop>
Mime-Version: 1.0
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


> > This list is getting way too much unrelated stuff, which I find
> > annoying, it would be nice if we were all a bit more careful here with
> > our CC lists.
> 
> Sorry, I only added device-tree because some one asked me to do so.
> 
>     http://marc.info/?l=linux-netdev&m=127273157912358
> 
> I'll leave it off next time.

That's allright. I'd rather you just post the bindings there than the
whole patch least but no big deal.

I was just fixing my email filters and notice a lot of seemingly
unrelated stuff landing there :-)

Cheers,
Ben.
