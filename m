Return-Path: <cmetcalf@tilera.com>
Received: from USMAMAIL.TILERA.COM (usmamail.tilera.com [206.83.70.75])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(Client CN "usmamail.tilera.com",
	Issuer "Go Daddy Secure Certification Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DF6D6B6F70
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 22:15:03 +1000 (EST)
Message-ID: <4DC141EC.5050406@tilera.com>
Date: Wed, 4 May 2011 08:09:16 -0400
From: Chris Metcalf <cmetcalf@tilera.com>
MIME-Version: 1.0
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Content-Type: text/plain; charset="ISO-8859-1"
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
	linux-m32r@ml.linux-m32r.org, linux-ia64@vger.kernel.org,
	linux-parisc@vger.kernel.org, linux-cris-kernel@axis.com,
	linux-s390@vger.kernel.org, linux-sh@vger.kernel.org,
	x86@kernel.org, linux-kernel@vger.kernel.org,
	David Howells <dhowells@redhat.com>,
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

On 5/3/2011 5:30 PM, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.
>
> Reported-by: David S. Miller <davem@davemloft.net>
> Signed-off-by: Sven Eckelmann <sven@narfation.org>
> [...]
>  arch/tile/include/asm/atomic.h     |    9 +++++++++
>  arch/tile/include/asm/atomic_32.h  |    1 +

Acked-by: Chris Metcalf <cmetcalf@tilera.com>

-- 
Chris Metcalf, Tilera Corp.
http://www.tilera.com
