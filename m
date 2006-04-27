Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id 9372E67A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:40:07 +1000 (EST)
Date: Thu, 27 Apr 2006 14:39:49 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 01/16] ehca: integration in Linux kernel	build system
Message-ID: <20060427123949.GH32127@wohnheim.fh-wedel.de>
References: <4450B384.4020601@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450B384.4020601@de.ibm.com>
Cc: schickhj@de.ibm.com, linux-kernel@vger.kernel.org,
	openib-general@openib.org, linuxppc-dev@ozlabs.org,
	Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 14:05:24 +0200, Heiko J Schick wrote:
> +
> +hcad_mod-objs = ehca_main.o   \
> +		ehca_hca.o    \
> +		ehca_mcast.o  \
> +		ehca_pd.o     \
> +		ehca_av.o     \
> +		ehca_eq.o     \
> +		ehca_cq.o     \
> +		ehca_qp.o     \
> +		ehca_sqp.o    \
> +		ehca_mrmw.o   \
> +		ehca_reqs.o   \
> +		ehca_irq.o    \
> +		ehca_uverbs.o \
> +		hcp_if.o      \
> +		hcp_phyp.o    \
> +		ipz_pt_fn.o

If you don't consolidate this into 2-3 lines, Sam might turn you into
a toad.

Jörn

-- 
Audacity augments courage; hesitation, fear.
-- Publilius Syrus 
