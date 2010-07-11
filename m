Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 27E84B728D
	for <linuxppc-dev@ozlabs.org>; Mon, 12 Jul 2010 02:07:29 +1000 (EST)
Subject: Re: [PATCH 3/3] powerpc/cpm1: Mark micropatch code/data static and
	__init
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20100708171616.GC11621@oksana.dev.rtsoft.ru>
Date: Sun, 11 Jul 2010 11:07:17 -0500
Message-Id: <8105B407-B167-47EE-97D3-B97BDA0001AF@kernel.crashing.org>
References: <20100708171616.GC11621@oksana.dev.rtsoft.ru>
To: Anton Vorontsov <avorontsov@mvista.com>
Cc: LEROY Christophe <christophe.leroy@c-s.fr>, linuxppc-dev@ozlabs.org,
	Scott Wood <scottwood@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Jul 8, 2010, at 12:16 PM, Anton Vorontsov wrote:

> This saves runtime memory and fixes lots of sparse warnings like this:
> 
>    CHECK   arch/powerpc/sysdev/micropatch.c
>  arch/powerpc/sysdev/micropatch.c:27:6: warning: symbol 'patch_2000'
>  was not declared. Should it be static?
>  arch/powerpc/sysdev/micropatch.c:146:6: warning: symbol 'patch_2f00'
>  was not declared. Should it be static?
>  ...
> 
> Signed-off-by: Anton Vorontsov <avorontsov@mvista.com>
> ---
> arch/powerpc/include/asm/cpm1.h  |    3 ++-
> arch/powerpc/sysdev/micropatch.c |   18 +++++++++---------
> 2 files changed, 11 insertions(+), 10 deletions(-)

applied to merge

- k
