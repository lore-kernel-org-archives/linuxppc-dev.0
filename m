Return-Path: <joern@wohnheim.fh-wedel.de>
Received: from wohnheim.fh-wedel.de (wohnheim.fh-wedel.de [213.39.233.138])
	by ozlabs.org (Postfix) with ESMTP id C2A4367A3F
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Apr 2006 22:37:23 +1000 (EST)
Date: Thu, 27 Apr 2006 14:37:01 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Heiko J Schick <schihei@de.ibm.com>
Subject: Re: [PATCH 13/16] ehca: firmware InfiniBand interface
Message-ID: <20060427123701.GG32127@wohnheim.fh-wedel.de>
References: <4450A1C0.3080209@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <4450A1C0.3080209@de.ibm.com>
Cc: linux-kernel@vger.kernel.org, openib-general@openib.org,
	linuxppc-dev@ozlabs.org, Christoph Raisch <RAISCH@de.ibm.com>,
	Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>, Marcus Eder <MEDER@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 27 April 2006 12:49:36 +0200, Heiko J Schick wrote:
> +u64 hipz_h_alloc_resource_qp(const struct ipz_adapter_handle 
> adapter_handle,
> +			     struct ehca_pfqp *pfqp,
> +			     const u8 servicetype,
> +			     const u8 daqp_ctrl,
> +			     const u8 signalingtype,
> +			     const u8 ud_av_l_key_ctl,
> +			     const struct ipz_cq_handle send_cq_handle,
> +			     const struct ipz_cq_handle receive_cq_handle,
> +			     const struct ipz_eq_handle async_eq_handle,
> +			     const u32 qp_token,
> +			     const struct ipz_pd pd,
> +			     const u16 max_nr_send_wqes,
> +			     const u16 max_nr_receive_wqes,
> +			     const u8 max_nr_send_sges,
> +			     const u8 max_nr_receive_sges,
> +			     const u32 ud_av_l_key,
> +			     struct ipz_qp_handle *qp_handle,
> +			     u32 * qp_nr,
> +			     u16 * act_nr_send_wqes,
> +			     u16 * act_nr_receive_wqes,
> +			     u8 * act_nr_send_sges,
> +			     u8 * act_nr_receive_sges,
> +			     u32 * nr_sq_pages,
> +			     u32 * nr_rq_pages,
> +			     struct h_galpas *h_galpas);

25 parameters?  If you tell me which drugs were involved in this code,
I know what to stay away from.  Might be the current record for any
code ever proposed for inclusion.

The whole patch is full of parameter-happy functions with this one
being the ugly top of the iceberg.  I sincerely hope this is not a
defined ABI and can still be changed.

Jörn

-- 
Debugging is twice as hard as writing the code in the first place.
Therefore, if you write the code as cleverly as possible, you are,
by definition, not smart enough to debug it.
-- Brian W. Kernighan
