Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C3541B7519
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon, 27 Jun 2011 23:35:18 +1000 (EST)
Subject: Re: [PATCH] powerpc/e500mc: Add support for the wait instruction in
	e500_idle
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <20110622231030.GA17242@schlenkerla.am.freescale.net>
Date: Mon, 27 Jun 2011 08:35:12 -0500
Message-Id: <6B3787BD-5B4C-4F72-83F0-B1ED0B86D38B@kernel.crashing.org>
References: <20110622231030.GA17242@schlenkerla.am.freescale.net>
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


On Jun 22, 2011, at 6:10 PM, Scott Wood wrote:

> e500mc cannot doze or nap due to an erratum (as well as having a
> different mechanism than previous e500), but it has a "wait" instruction
> that is similar to doze.
> 
> On 64-bit, due to the soft-irq-disable mechanism, the existing
> book3e_idle should be used instead.
> 
> Signed-off-by: Vakul Garg <vakul@freescale.com>
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> ---
> arch/powerpc/kernel/idle_e500.S        |   12 ++++++++++++
> arch/powerpc/platforms/85xx/p3041_ds.c |    1 +
> arch/powerpc/platforms/85xx/p4080_ds.c |    1 +
> arch/powerpc/platforms/85xx/p5020_ds.c |    5 +++++
> 4 files changed, 19 insertions(+), 0 deletions(-)

applied to next

- K
