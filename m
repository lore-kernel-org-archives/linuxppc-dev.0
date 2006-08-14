Return-Path: <ossthema@de.ibm.com>
Received: from mtagate1.de.ibm.com (mtagate1.de.ibm.com [195.212.29.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A34DA679FC
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 23:53:25 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate1.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7EDrJeC050164
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 13:53:20 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7EDv7ZK155520
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 15:57:07 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7EDrJd9025824
	for <linuxppc-dev@ozlabs.org>; Mon, 14 Aug 2006 15:53:19 +0200
Message-ID: <44E07732.4010508@de.ibm.com>
Date: Mon, 14 Aug 2006 15:14:26 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
References: <44D99F1A.4080905@de.ibm.com> <20060811211314.GF479@krispykreme>
In-Reply-To: <20060811211314.GF479@krispykreme>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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

Hi

Anton Blanchard wrote:
 > Hi,
 >
 >> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_phyp.c       1969-12-31 16:00:00.000000000 -0800
 >
 >> +u64 ehea_h_alloc_resource_eq(const u64 hcp_adapter_handle,
 > ...
 >> +u64 hipz_h_reregister_pmr(const u64 adapter_handle,
 > ...
 >> +static inline int hcp_galpas_ctor(struct h_galpas *galpas,
 >
 > Be nice to have some consistent names, hipz_ and hcp_ is kind of
 > cryptic.

We choose some more meaningful names and added comments to explain those.

 >
 >> +#define H_QP_CR_STATE_RESET     0x0000010000000000  /*  Reset */
 >
 > Probably want ULL on here and the other 64bit constants.
 >

ULL added

 > Anton

Jan-Bernd
