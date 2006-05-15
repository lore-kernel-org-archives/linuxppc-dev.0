Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id 2BBD9679FC
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 06:55:17 +1000 (EST)
Received: from midway.site ([71.245.102.105]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 13:45:08 -0700
Date: Mon, 15 May 2006 13:47:37 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 12/16] ehca: firmware InfiniBand interface
Message-Id: <20060515134737.c03e02d3.rdunlap@xenotime.net>
In-Reply-To: <4468BD99.5050505@de.ibm.com>
References: <4468BD99.5050505@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, RAISCH@de.ibm.com, HNGUYEN@de.ibm.com,
	MEDER@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 15 May 2006 19:42:49 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/hcp_if.c | 1476 ++++++++++++++++++++++++++++++++++++
>   drivers/infiniband/hw/ehca/hcp_if.h |  330 ++++++++
>   2 files changed, 1806 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/hcp_if.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/hcp_if.h	2006-05-12 12:48:21.000000000 +0200
> @@ -0,0 +1,330 @@

> +/**
> + * hipz_h_alloc_resource_eq - Allocate EQ resources in HW and FW, initalize
> + * resources, create the empty EQPT (ring).
> + *
> + * @eq_handle:         eq handle for this queue
> + * @act_nr_of_entries: actual number of queue entries
> + * @act_pages:         actual number of queue pages
> + * @eq_ist:            used by hcp_H_XIRR() call
> + */

kernel-doc format needs:
1.  a short function name + description on one line
2.  no blank line between function and parameters
3.  blank line (optional) before more detailed function description

See Documentation/kernel-doc-nano-HOWTO.txt or other kernel source
files for more info.
And please test it with "make htmldocs" or "make mandocs".

---
~Randy
