Return-Path: <glikely@secretlab.ca>
Received: from rn-out-0910.google.com (rn-out-0910.google.com [64.233.170.184])
	by ozlabs.org (Postfix) with ESMTP id 46CE0DDDE3
	for <linuxppc-dev@ozlabs.org>; Fri, 28 Nov 2008 01:11:17 +1100 (EST)
Received: by rn-out-0910.google.com with SMTP id j40so891616rnf.16
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Nov 2008 06:11:14 -0800 (PST)
Message-ID: <fa686aa40811270611j58ceb6e5lffc37fc3f83d00e7@mail.gmail.com>
Date: Thu, 27 Nov 2008 07:11:13 -0700
From: "Grant Likely" <grant.likely@secretlab.ca>
To: "Yuri Tikhonov" <yur@emcraft.com>
Subject: Re: [PATCH][v2] xsysace: use resource_size_t instead of unsigned long
In-Reply-To: <200811271521.27642.yur@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <200811271521.27642.yur@emcraft.com>
Cc: linuxppc-dev@ozlabs.org, Ilya Yanok <yanok@emcraft.com>,
	linux-kernel@vger.kernel.org, Detlev Zundel <dzu@denx.de>,
	Wolfgang Denk <wd@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 27, 2008 at 5:21 AM, Yuri Tikhonov <yur@emcraft.com> wrote:
> Use resource_size_t for physical address of SystemACE
> chip. This fixes the driver brokeness for 32 bit systems
> with 64 bit resources (e.g. PPC440SPe).

Hey Yuri,

I actually already picked up the last version of your patch after
fixing it up myself.  It's currently sitting in Paul's powerpc tree
and it will be merged into mainline when Linus gets back from
vacation.

Can you please spin a new version with just the addition of the
compatible value and base it on Paul's tree.

Thanks,
g.
