Return-Path: <neko@genesi-usa.com>
Received: from yx-out-2324.google.com (yx-out-2324.google.com [74.125.44.28])
	by ozlabs.org (Postfix) with ESMTP id 609B7DDF94
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jan 2009 04:52:42 +1100 (EST)
Received: by yx-out-2324.google.com with SMTP id 8so2454385yxg.39
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 09:52:40 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20090121205540.31232.77034.stgit@localhost.localdomain>
References: <20090121205506.31232.27908.stgit@localhost.localdomain>
	<20090121205540.31232.77034.stgit@localhost.localdomain>
Date: Tue, 27 Jan 2009 11:52:40 -0600
Message-ID: <b5e2fc790901270952p42fefb5fx63b77449528a448c@mail.gmail.com>
Subject: Re: [PATCH 7/8] powerpc/5200: Refactor mpc5200 interrupt controller
	driver
From: Matt Sealey <matt@genesi-usa.com>
To: Grant Likely <grant.likely@secretlab.ca>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 21, 2009 at 2:55 PM, Grant Likely <grant.likely@secretlab.ca> wrote:
> From: Grant Likely <grant.likely@secretlab.ca>
>
> Rework the mpc5200-pic driver to simplify it and fix up the setting
> of desc->status when set_type is called for internal IRQs (so they
> are reported as level, not edge).  The simplification is due to
> splitting off the handling of external IRQs into a separate block
> so they don't need to be handled as exceptions in the normal
> CRIT, MAIN and PERP paths.
>
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> CC: Wolfram Sang <w.sang@pengutronix.de>

Can I assume this has absolutely no functional impact compared to the
old one? It doesn't change any behaviour, just implements exactly the
same in a much nicer way?

-- 
Matt Sealey <matt@genesi-usa.com>
Genesi, Manager, Developer Relations
