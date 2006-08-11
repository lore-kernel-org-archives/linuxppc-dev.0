Return-Path: <anton@ozlabs.org>
Date: Sat, 12 Aug 2006 07:13:14 +1000
From: Anton Blanchard <anton@samba.org>
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Message-ID: <20060811211314.GF479@krispykreme>
References: <44D99F1A.4080905@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44D99F1A.4080905@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Hi,

> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c	1969-12-31 16:00:00.000000000 -0800

> +u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
...
> +u64 hipz_h_reregister_pmr(const u64 adapter_handle,
...
> +static inline int hcp_galpas_ctor(struct h_galpas *galpas,

Be nice to have some consistent names, hipz_ and hcp_ is kind of
cryptic.

> +#define H_QP_CR_STATE_RESET	    0x0000010000000000	/*  Reset */

Probably want ULL on here and the other 64bit constants.

Anton
