Return-Path: <ralf@linux-mips.org>
Received: from linux-mips.org (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9C716B70C7
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  2 Aug 2011 20:14:47 +1000 (EST)
Date: Tue, 2 Aug 2011 10:58:14 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCHv4 01/11] atomic: add *_dec_not_zero
Message-ID: <20110802095814.GA22947@linux-mips.org>
References: <1311760070-21532-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1311760070-21532-1-git-send-email-sven@narfation.org>
Cc: linux-m32r-ja@ml.linux-m32r.org, linux-mips@linux-mips.org,
	linux-ia64@vger.kernel.org, linux-doc@vger.kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Heiko Carstens <heiko.carstens@de.ibm.com>,
	Randy Dunlap <rdunlap@xenotime.net>,
	Paul Mackerras <paulus@samba.org>, Helge Deller <deller@gmx.de>,
	sparclinux@vger.kernel.org, linux-arch@vger.kernel.org,
	linux-s390@vger.kernel.org, Russell King <linux@arm.linux.org.uk>,
	user-mode-linux-devel@lists.sourceforge.net,
	Richard Weinberger <richard@nod.at>,
	Hirokazu Takata <takata@linux-m32r.org>, x86@kernel.org,
	"James E.J. Bottomley" <jejb@parisc-linux.org>,
	Ingo Molnar <mingo@redhat.com>, Matt Turner <mattst88@gmail.com>,
	Fenghua Yu <fenghua.yu@intel.com>, Arnd Bergmann <arnd@arndb.de>,
	Jeff Dike <jdike@addtoit.com>, Chris Metcalf <cmetcalf@tilera.com>,
	linux-m32r@ml.linux-m32r.org, Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
	Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
	Richard Henderson <rth@twiddle.net>,
	Tony Luck <tony.luck@intel.com>, linux-parisc@vger.kernel.org,
	linux-kernel@vger.kernel.org, Kyle McMartin <kyle@mcmartin.ca>,
	linux-alpha@vger.kernel.org,
	Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
	linuxppc-dev@lists.ozlabs.org, "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 27, 2011 at 11:47:40AM +0200, Sven Eckelmann wrote:

For MIPS:

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
