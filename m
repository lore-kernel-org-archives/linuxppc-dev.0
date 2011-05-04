Return-Path: <jesper.nilsson@axis.com>
Received: from anubis.se.axis.com (anubis.se.axis.com [195.60.68.12])
	by ozlabs.org (Postfix) with ESMTP id 6F252B6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  4 May 2011 20:56:03 +1000 (EST)
Date: Wed, 4 May 2011 12:48:41 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: Sven Eckelmann <sven@narfation.org>
Subject: Re: [PATCH] atomic: add *_dec_not_zero
Message-ID: <20110504104841.GE16179@axis.com>
References: <1304458235-28473-1-git-send-email-sven@narfation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1304458235-28473-1-git-send-email-sven@narfation.org>
Cc: "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
	"linux-mips@linux-mips.org" <linux-mips@linux-mips.org>,
	"linux-m68k@lists.linux-m68k.org" <linux-m68k@vger.kernel.org>,
	"linux-m32r@ml.linux-m32r.org" <linux-m32r@ml.linux-m32r.org>,
	"linux-ia64@vger.kernel.org" <linux-ia64@vger.kernel.org>,
	linux-cris-kernel <linux-cris-kernel@axis.com>,
	"linux-parisc@vger.kernel.org" <linux-parisc@vger.kernel.org>,
	"linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
	"linux-sh@vger.kernel.org" <linux-sh@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
	Chris Metcalf <cmetcalf@tilera.com>, David Howells <dhowells@redhat.com>,
	"linux-am33-list@redhat.com" <linux-am33-list@redhat.com>,
	"linux-alpha@vger.kernel.org" <linux-alpha@vger.kernel.org>,
	"sparclinux@vger.kernel.org" <sparclinux@vger.kernel.org>,
	"uclinux-dist-devel@blackfin.uclinux.org"
	<uclinux-dist-devel@blackfin.uclinux.org>,
	"x86@kernel.org" <x86@kernel.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2011 at 11:30:35PM +0200, Sven Eckelmann wrote:
> Introduce an *_dec_not_zero operation.  Make this a special case of
> *_add_unless because batman-adv uses atomic_dec_not_zero in different
> places like re-broadcast queue or aggregation queue management. There
> are other non-final patches which may also want to use this macro.

For the CRIS-part:

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
