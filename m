Return-Path: <computersforpeace@gmail.com>
Received: from mail-pd0-x22f.google.com (mail-pd0-x22f.google.com
 [IPv6:2607:f8b0:400e:c02::22f])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 71BB11A0272
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Mar 2015 11:55:48 +1100 (AEDT)
Received: by pddn5 with SMTP id n5so2735373pdd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2015 17:55:45 -0700 (PDT)
Date: Mon, 30 Mar 2015 17:55:38 -0700
From: Brian Norris <computersforpeace@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH 6/8] mtd: replace CONFIG_8xx by CONFIG_PPC_8xx
Message-ID: <20150331005538.GJ32500@ld-irv-0074>
References: <20150312152404.D6C391A2421@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150312152404.D6C391A2421@localhost.localdomain>
Cc: linux-fbdev@vger.kernel.org, linux-serial@vger.kernel.org,
 user-mode-linux-devel@lists.sourceforge.net,
 David Woodhouse <dwmw2@infradead.org>, linux-kernel@vger.kernel.org,
 linux-mtd@lists.infradead.org, user-mode-linux-user@lists.sourceforge.net,
 netdev@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 12, 2015 at 04:24:04PM +0100, Christophe Leroy wrote:
> Two config options exist to define powerpc MPC8xx:
> * CONFIG_PPC_8xx
> * CONFIG_8xx
> In addition, CONFIG_PPC_8xx also defines CONFIG_CPM1 as
> communication co-processor
> 
> arch/powerpc/platforms/Kconfig.cputype has contained the following
> comment about CONFIG_8xx item for some years:
> "# this is temp to handle compat with arch=ppc"
> 
> It looks like not many places still have that old CONFIG_8xx used,
> so it is likely to be a good time to get rid of it completely ?
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

I'm not sure if the consistency aspect is worked out for all symbols
(Geert's comment on the cover letter), but this one looks fine.

Applied this patch to l2-mtd.git.

Brian
