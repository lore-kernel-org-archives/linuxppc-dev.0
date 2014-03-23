Return-Path: <BATV+4e0fa7f094f67dc0867c+3864+infradead.org+hch@bombadil.srs.infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 2BEAA2C00AF
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 23 Mar 2014 18:04:59 +1100 (EST)
Date: Sun, 23 Mar 2014 00:03:43 -0700
From: Christoph Hellwig <hch@infradead.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [RESEND][PATCH 1/2] lib/scatterlist: Make ARCH_HAS_SG_CHAIN an
 actual Kconfig
Message-ID: <20140323070343.GA17945@infradead.org>
References: <1395512032-20575-1-git-send-email-lauraa@codeaurora.org>
 <1395512032-20575-2-git-send-email-lauraa@codeaurora.org>
 <1395543886.3460.95.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1395543886.3460.95.camel@pasglop>
Cc: linux-ia64@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Paul Mackerras <paulus@samba.org>, "H. Peter Anvin" <hpa@zytor.com>,
 sparclinux@vger.kernel.org, linux-s390@vger.kernel.org,
 Russell King <linux@arm.linux.org.uk>, linux-scsi@vger.kernel.org,
 x86@kernel.org, Ingo Molnar <mingo@redhat.com>,
 Fenghua Yu <fenghua.yu@intel.com>, Laura Abbott <lauraa@codeaurora.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
 "James E.J. Bottomley" <JBottomley@parallels.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linux390@de.ibm.com,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 "David S. Miller" <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Mar 23, 2014 at 02:04:46PM +1100, Benjamin Herrenschmidt wrote:
> 
> > diff --git a/arch/arm/Kconfig b/arch/arm/Kconfig
> > index 1594945..8122294 100644
> > --- a/arch/arm/Kconfig
> > +++ b/arch/arm/Kconfig
> > @@ -82,6 +82,7 @@ config ARM
> >  	  <http://www.arm.linux.org.uk/>.
> >  
> >  config ARM_HAS_SG_CHAIN
> > +	select ARCH_HAS_SG_CHAIN
> >  	bool
> >  
> 
> Heh, a self-selecting config option... I didn't know that trick !

ARM vs ARCH.  However the arm variant of the variable should probably be
consolidated into the ARCH one as a follow up.
