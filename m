Return-Path: <davem@davemloft.net>
Received: from sunset.davemloft.net
	(74-93-104-97-Washington.hfc.comcastbusiness.net [74.93.104.97])
	by ozlabs.org (Postfix) with ESMTP id AC464B6F4E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 16:13:30 +1000 (EST)
Date: Tue, 03 May 2011 23:12:55 -0700 (PDT)
Message-Id: <20110503.231255.115931602.davem@davemloft.net>
To: sven@narfation.org
Subject: Re: [PATCH] atomic: add *_dec_not_zero
From: David Miller <davem@davemloft.net>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	cmetcalf@tilera.com, dhowells@redhat.com,
	linux-m68k@lists.linux-m68k.org, linux-am33-list@redhat.com,
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

From: Sven Eckelmann <sven@narfation.org>
Date: Tue,  3 May 2011 23:30:35 +0200

> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
> 
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>

Acked-by: David S. Miller <davem@davemloft.net>
