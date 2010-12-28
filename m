Return-Path: <cbouatmailru@gmail.com>
Received: from mail-ey0-f179.google.com (mail-ey0-f179.google.com
	[209.85.215.179]) (using TLSv1 with cipher RC4-MD5 (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 63BC0B6EEB
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 03:05:36 +1100 (EST)
Received: by eyg24 with SMTP id 24so4194147eyg.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Dec 2010 08:05:31 -0800 (PST)
Date: Tue, 28 Dec 2010 19:05:26 +0300
From: Anton Vorontsov <cbouatmailru@gmail.com>
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [PATCH] of_mmc_spi: add card detect irq support
Message-ID: <20101228160526.GA20087@oksana.dev.rtsoft.ru>
References: <20100830161102.GA20413@oksana.dev.rtsoft.ru>
	<172136.90988.qm@web180315.mail.gq1.yahoo.com>
	<AANLkTimXJ-hSz3O1xPgLsZLxwkwBeqrW+gAmR8+6jGoW@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
In-Reply-To: <AANLkTimXJ-hSz3O1xPgLsZLxwkwBeqrW+gAmR8+6jGoW@mail.gmail.com>
Cc: David Brownell <dbrownell@users.sourceforge.net>,
	Esben Haabendal <esbenhaabendal@gmail.com>,
	linux-mmc@vger.kernel.org, David Brownell <david-b@pacbell.net>,
	Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 30, 2010 at 11:49:08AM -0600, Grant Likely wrote:
> On Mon, Aug 30, 2010 at 10:38 AM, David Brownell <david-b@pacbell.net> wrote:
> > Since I don't do OpenFirmware, let's hear from
> > Grant on this one.
> 
> Looks good to me.
> 
> Acked-by: Grant Likely <grant.likely@secretlab.ca>

I wonder what happened with this patch?

Thanks,

-- 
Anton Vorontsov
Email: cbouatmailru@gmail.com
