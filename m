Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0143.outbound.protection.outlook.com [157.56.111.143])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id D223C1A1961
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Sep 2014 02:41:00 +1000 (EST)
Message-ID: <1410972043.24184.532.camel@snotra.buserror.net>
Subject: Re: [PATCH v3 00/21] powerpc/8xx: Optimise MMU TLB handling and add
 support of 16k pages
From: Scott Wood <scottwood@freescale.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Date: Wed, 17 Sep 2014 11:40:43 -0500
In-Reply-To: <20140917163656.E09D81AB026@localhost.localdomain>
References: <20140917163656.E09D81AB026@localhost.localdomain>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-09-17 at 18:36 +0200, Christophe Leroy wrote:
> This patchset:
> 1) provides several MMU TLB handling optimisation on MPC8xx.
> 2) adds support of 16k pages on MPC8xx.
> All changes have been successfully tested on a custom board equipped with MPC885
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> Tested-by: Christophe Leroy <christophe.leroy@c-s.fr>

I've already applied patches 1, 2, 4, 5, 6, 9, and 10 from the previous
patchset -- have they changed?

-Scott
