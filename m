Return-Path: <tglx@linutronix.de>
Received: from www.tglx.de (www.tglx.de [62.245.132.106])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 77F3BB70EC
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 24 Sep 2010 08:34:17 +1000 (EST)
Date: Fri, 24 Sep 2010 00:12:19 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 1/8] posix clocks: introduce a syscall for clock
 tuning.
In-Reply-To: <1285279423.5158.20.camel@pasglop>
Message-ID: <alpine.LFD.2.00.1009240008390.2416@localhost6.localdomain6>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<b94ef1cd9c04ef3ad5964408bd0af7251add78de.1285261534.git.richard.cochran@omicron.at>
	<1285279423.5158.20.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
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

On Fri, 24 Sep 2010, Benjamin Herrenschmidt wrote:
> On Thu, 2010-09-23 at 19:31 +0200, Richard Cochran wrote:
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

Says the guy who missed to trim the useless context of the original
mail, which made me scroll down all the way just to find out that
there is nothing to see.

Thanks,

	tglx
