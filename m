Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 67628DDFDB
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Aug 2008 14:50:16 +1000 (EST)
Message-Id: <D84FB45E-DD03-4F27-91D6-61C66C9BB59D@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1219246149-23812-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v926)
Subject: Re: [PATCH v2] powerpc: fix memory leaks in QE library
Date: Wed, 20 Aug 2008 23:49:49 -0500
References: <1219246149-23812-1-git-send-email-timur@freescale.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Aug 20, 2008, at 10:29 AM, Timur Tabi wrote:

> Fix two memory leaks in the Freescale QE library: add a missing  
> kfree() in
> ucc_fast_init() and ucc_slow_init() if the ioremap() fails, and update
> ucc_fast_free() and ucc_slow_free() to call iounmap() if necessary.
>
> Based on a patch from Tony Breeds <tony@bakeyournoodle.com>.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
> arch/powerpc/sysdev/qe_lib/ucc_fast.c |    4 ++++
> arch/powerpc/sysdev/qe_lib/ucc_slow.c |    8 +++++---
> 2 files changed, 9 insertions(+), 3 deletions(-)

applied.  (this just became ucc_slow since I had already applied v1).

- k
