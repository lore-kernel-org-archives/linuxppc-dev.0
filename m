Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vWzD937sNzDqC0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Feb 2017 21:56:41 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Andrew Donnellan  <andrew.donnellan@au1.ibm.com>,
 Oliver O'Halloran  <oohall@gmail.com>
Cc: Matt Brown <matthew.brown.dev@gmail.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v3] powerpc/powernv: add hdat attribute to sysfs
In-Reply-To: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
References: <20170224062054.31408-1-matthew.brown.dev@gmail.com>
Date: Mon, 27 Feb 2017 21:56:40 +1100
Message-ID: <87lgsrrjfb.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Matt Brown <matthew.brown.dev@gmail.com> writes:
> diff --git a/arch/powerpc/platforms/powernv/opal-hdat.c b/arch/powerpc/platforms/powernv/opal-hdat.c
> new file mode 100644
> index 0000000..3315dd3
> --- /dev/null
> +++ b/arch/powerpc/platforms/powernv/opal-hdat.c
> @@ -0,0 +1,65 @@
...
> +
> +
> +/* HDAT attribute for sysfs */
> +static struct bin_attribute hdat_attr = {
> +	.attr = {.name = "hdat", .mode = 0444},
                                         ^^^^
ajd and oohal report to my office.

cheers
