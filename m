Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id EC6961007D5
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 15:41:36 +1000 (EST)
Subject: Re: [PATCH] powerpc/e5500: set non-base IVORs
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110509212600.GA29190@schlenkerla.am.freescale.net>
Date: Thu, 19 May 2011 00:41:29 -0500
Message-Id: <B794A6BF-1B01-4764-92BA-A486A0166EB8@kernel.crashing.org>
References: <20110509212600.GA29190@schlenkerla.am.freescale.net>
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 9, 2011, at 4:26 PM, Scott Wood wrote:

> Without this, we attempt to use doorbells for IPIs, and end up
> branching to some bad address.  Plus, even for the exceptions
> we don't implement, it's good to handle it and get a message out.
>=20
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/include/asm/reg_booke.h      |    4 ++
> arch/powerpc/kernel/cpu_setup_fsl_booke.S |    3 ++
> arch/powerpc/kernel/exceptions-64e.S      |   47 =
+++++++++++++++++++++++++++++
> 3 files changed, 54 insertions(+), 0 deletions(-)

applied to next

- k
