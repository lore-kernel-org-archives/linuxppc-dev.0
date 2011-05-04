Return-Path: <dhowells@redhat.com>
Received: from mx1.redhat.com (mx1.redhat.com [209.132.183.28])
	by ozlabs.org (Postfix) with ESMTP id 8DA21B6F72
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 21:54:26 +1000 (EST)
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Date: Wed, 04 May 2011 12:53:19 +0100
Message-ID: <20684.1304509999@redhat.com>
Sender: dhowells@redhat.com
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m68k@vger.kernel.org, linux-m32r@ml.linux-m32r.org,
	linux-ia64@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-cris-kernel@axis.com, linux-s390@vger.kernel.org,
	linux-sh@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org,
	Chris Metcalf <cmetcalf@tilera.com>, dhowells@redhat.com,
	linux-am33-list@redhat.com, linux-alpha@vger.kernel.org,
	sparclinux@vger.kernel.org, uclinux-dist-devel@blackfin.uclinux.org,
	linuxppc-dev@lists.ozlabs.org, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Sven Eckelmann <sven@narfation.org> wrote:

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: David Howells <dhowells@redhat.com> [MN10300 and FRV]
