Return-Path: <cbouatmailru@gmail.com>
Received: from mail-wy0-f179.google.com (mail-wy0-f179.google.com
	[74.125.82.179]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 303ECB700E
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 20:05:00 +1000 (EST)
Received: by wyh22 with SMTP id 22so2134355wyh.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 12 Aug 2011 03:04:55 -0700 (PDT)
Date: Fri, 12 Aug 2011 14:04:50 +0400
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Zang Roy-R61911 <r61911@freescale.com>
Subject: Re: [PATCH 2/2 v2] eSDHC: Fix errors when booting kernel with fsl
	esdhc
Message-ID: <20110812100450.GA23333@oksana.dev.rtsoft.ru>
References: <1311329717-13954-1-git-send-email-tie-fei.zang@freescale.com>
	<1311329717-13954-2-git-send-email-tie-fei.zang@freescale.com>
	<20110722101512.GA1576@oksana.dev.rtsoft.ru>
	<2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <2239AC579C7D3646A720227A37E0268118FD3B@039-SN1MPN1-005.039d.mgd.msft.net>
Cc: Wood Scott-B07421 <B07421@freescale.com>,
	Xu Lei-B33228 <B33228@freescale.com>,
	"linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>,
	"akpm@linux-foundation.org" <akpm@linux-foundation.org>,
	"linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hello,

On Fri, Aug 12, 2011 at 09:44:26AM +0000, Zang Roy-R61911 wrote:
[...]
> > We try to not pollute generic sdhci.c driver with chip-specific
> > quirks.
> > 
> > Maybe you can do the fixups via IO accessors? Or by introducing
> > some additional sdhci op?
> Anton,
> thanks for the comment, as we discussed, the original code use 8 bit byte operation,
> while in fact, on some powerpc platform, 32 bit operation is needed. 
> should it be possible fixed by adding some wrapper in IO accessors or introduce additional sdhci op?

I would do it in the IO accessors.

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
