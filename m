Return-Path: <rdunlap@xenotime.net>
Received: from xenotime.net (xenotime.net [66.160.160.81])
	by ozlabs.org (Postfix) with SMTP id DBF3A679F8
	for <linuxppc-dev@ozlabs.org>; Tue, 16 May 2006 07:12:00 +1000 (EST)
Received: from midway.site ([71.245.102.105]) by xenotime.net for
	<linuxppc-dev@ozlabs.org>; Mon, 15 May 2006 14:11:59 -0700
Date: Mon, 15 May 2006 14:14:28 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 01/16] ehca: module infrastructure
Message-Id: <20060515141428.03800e3e.rdunlap@xenotime.net>
In-Reply-To: <4468BD39.3010008@de.ibm.com>
References: <4468BD39.3010008@de.ibm.com>
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

On Mon, 15 May 2006 19:41:13 +0200 Heiko J Schick wrote:

> Signed-off-by: Heiko J Schick <schickhj@de.ibm.com>
> 
> 
>   drivers/infiniband/hw/ehca/ehca_main.c |  966 +++++++++++++++++++++++++++++++++
>   1 file changed, 966 insertions(+)
> 
> 
> 
> --- linux-2.6.17-rc2-orig/drivers/infiniband/hw/ehca/ehca_main.c	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.17-rc2/drivers/infiniband/hw/ehca/ehca_main.c	2006-05-15 19:17:26.000000000 +0200

> @@ -0,0 +1,966 @@

> +int ehca_open_aqp1     = 0;
> +int ehca_debug_level   = -1;
> +int ehca_hw_level      = 0;
> +int ehca_nr_ports      = 2;
> +int ehca_use_hp_mr     = 0;
> +int ehca_port_act_time = 30;
> +int ehca_poll_all_eqs  = 1;
> +int ehca_static_rate   = -1;

Don't need to init globals to 0.

---
~Randy
