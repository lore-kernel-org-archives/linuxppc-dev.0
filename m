Return-Path: <cl@linux.com>
Received: from smtp102.prem.mail.ac4.yahoo.com
	(smtp102.prem.mail.ac4.yahoo.com [76.13.13.41])
	by ozlabs.org (Postfix) with SMTP id 9616FB70E0
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 01:56:15 +1000 (EST)
Date: Mon, 27 Sep 2010 10:56:09 -0500 (CDT)
From: Christoph Lameter <cl@linux.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [PATCH v6 0/8] ptp: IEEE 1588 hardware clock support
In-Reply-To: <20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
Message-ID: <alpine.DEB.2.00.1009271054320.9258@router.home>
References: <cover.1285261533.git.richard.cochran@omicron.at>
	<20100923213654.0c64b047@lxorguk.ukuu.org.uk>
	<20100924131407.GA3113@riccoc20.at.omicron.at>
	<20100924150246.0e6064b6@lxorguk.ukuu.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: John Stultz <johnstul@us.ibm.com>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org,
	linux-kernel@vger.kernel.org, David Miller <davem@davemloft.net>,
	netdev@vger.kernel.org, Thomas Gleixner <tglx@linutronix.de>,
	linuxppc-dev@lists.ozlabs.org, Richard Cochran <richardcochran@gmail.com>,
	linux-arm-kernel@lists.infradead.org, Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Fri, 24 Sep 2010, Alan Cox wrote:

> Whether you add new syscalls or do the fd passing using flags and hide
> the ugly bits in glibc is another question.

Use device specific ioctls instead of syscalls?
