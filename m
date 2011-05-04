Return-Path: <will.deacon@arm.com>
Received: from cam-admin0.cambridge.arm.com (cam-admin0.cambridge.arm.com
	[217.140.96.50]) by ozlabs.org (Postfix) with ESMTP id 81DC9B6F06
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu,  5 May 2011 03:57:44 +1000 (EST)
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From: Will Deacon <will.deacon@arm.com>
To: Sven Eckelmann <sven@narfation.org>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="UTF-8"
Date: Wed, 04 May 2011 18:27:36 +0100
Message-ID: <1304530056.2296.1.camel@craptop>
Mime-Version: 1.0
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	linux-ia64@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-parisc@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>,
	David Howells <dhowells@redhat.com>, linux-am33-list@redhat.com,
	linux-alpha@vger.kernel.org, sparclinux@vger.kernel.org,
	uclinux-dist-devel@blackfin.uclinux.org, x86@kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2011-05-03 at 22:30 +0100, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
For the ARM changes:

Acked-by: Will Deacon <will.deacon@arm.com>

Cheers,

Will
