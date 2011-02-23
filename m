Return-Path: <richardcochran@gmail.com>
Date: Wed, 23 Feb 2011 11:50:07 +0100
From: Richard Cochran <richardcochran@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH V11 0/4] ptp: IEEE 1588 hardware clock support
Message-ID: <20110223105007.GA31292@riccoc20.at.omicron.at>
References: <cover.1298447722.git.richard.cochran@omicron.at>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <cover.1298447722.git.richard.cochran@omicron.at>
Cc: Thomas Gleixner <tglx@linutronix.de>, Rodolfo Giometti <giometti@linux.it>,
	Arnd Bergmann <arnd@arndb.de>,
	Peter Zijlstra <peterz@infradead.org>, linux-api@vger.kernel.org,
	devicetree-discuss@lists.ozlabs.org, Russell King <linux@arm.linux.org.uk>,
	Paul Mackerras <paulus@samba.org>, John Stultz <john.stultz@linaro.org>,
	linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org,
	Mike Frysinger <vapier@gentoo.org>,
	Christoph Lameter <cl@linux.com>, linuxppc-dev@lists.ozlabs.org,
	David Miller <davem@davemloft.net>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
	Krzysztof Halasa <khc@pm.waw.pl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Previous Discussions

  This patch set previously appeared on the netdev list. Since V5 of
  the character device patch set, the discussion has moved to the
  lkml.

  - IEEE 1588 hardware clock support [V5]
    http://lkml.org/lkml/2010/8/16/90

  - POSIX clock tuning syscall with static clock ids
    http://lkml.org/lkml/2010/8/23/49

  - POSIX clock tuning syscall with dynamic clock ids
    http://lkml.org/lkml/2010/9/3/119

  - IEEE 1588 hardware clock support [V6]
    http://lkml.org/lkml/2010/9/23/310

  - Dynamic clock devices [RFC]
    http://lkml.org/lkml/2010/11/4/290

  - IEEE 1588 hardware clock support [V7]
    http://lkml.org/lkml/2010/12/16/195

  - IEEE 1588 hardware clock support [V8]
    http://lkml.org/lkml/2010/12/31/128

  - IEEE 1588 hardware clock support [V9]
    http://lkml.org/lkml/2011/1/13/65

  - IEEE 1588 hardware clock support [V10]
    http://lkml.org/lkml/2011/1/27/71

  - Thomas Gleixner: Rework of the PTP support series core code
    http://lkml.org/lkml/2011/2/1/137
