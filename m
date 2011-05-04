Return-Path: <ralf@linux-mips.org>
Received: from duck.linux-mips.net (h5.dl5rb.org.uk [81.2.74.5])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6B27AB6F4D
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 21:06:17 +1000 (EST)
Date: Wed, 4 May 2011 12:02:07 +0100
From: Ralf Baechle <ralf@linux-mips.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Message-ID: <20110504110207.GA4243@linux-mips.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>,
	David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, linuxppc-dev@lists.ozlabs.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2011 at 11:30:35PM +0200, Sven Eckelmann wrote:

>  arch/mips/include/asm/atomic.h     |    2 ++
>  arch/mips/include/asm/local.h      |    1 +

Acked-by: Ralf Baechle <ralf@linux-mips.org>

  Ralf
