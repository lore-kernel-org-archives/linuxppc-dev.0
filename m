Return-Path: <arnd.bergmann@de.ibm.com>
Received: from e2.ny.us.ibm.com (e2.ny.us.ibm.com [32.97.182.142])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e2.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B464067BB1
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Aug 2006 23:14:51 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e2.ny.us.ibm.com (8.12.11.20060308/8.12.11) with ESMTP id
	k79DEmqk031544
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:14:48 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k79DEmCp285654
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:14:48 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	k79DElb6017245
	for <linuxppc-dev@ozlabs.org>; Wed, 9 Aug 2006 09:14:48 -0400
From: Arnd Bergmann <arnd.bergmann@de.ibm.com>
To: linuxppc-dev@ozlabs.org
Subject: Re: [PATCH 2/6] ehea: pHYP interface
Date: Wed, 9 Aug 2006 15:14:46 +0200
References: <44D99F1A.4080905@de.ibm.com>
In-Reply-To: <44D99F1A.4080905@de.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200608091514.46861.arnd.bergmann@de.ibm.com>
Cc: Thomas Klein <tklein@de.ibm.com>, netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 09 August 2006 10:38, Jan-Bernd Themann wrote:
> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hcall.h=A01969-12-31 16:0=
0:00.000000000 -0800
> +++ kernel/drivers/net/ehea/ehea_hcall.h=A0=A0=A0=A0=A0=A0=A0=A02006-08-0=
8 23:59:38.111462960 -0700
> @@ -0,0 +1,52 @@

> +
> +/**
> + * This file contains HCALL defines that are to be included in the appro=
priate
> + * kernel files later
> + */
> +
> +#define H_ALLOC_HEA_RESOURCE =A0 0x278
> +#define H_MODIFY_HEA_QP =A0 =A0 =A0 =A00x250
> +#define H_QUERY_HEA_QP =A0 =A0 =A0 =A0 0x254
> +#define H_QUERY_HEA =A0 =A0 =A0 =A0 =A0 =A00x258
> +#define H_QUERY_HEA_PORT =A0 =A0 =A0 0x25C
> +#define H_MODIFY_HEA_PORT =A0 =A0 =A00x260
> +#define H_REG_BCMC =A0 =A0 =A0 =A0 =A0 =A0 0x264
> +#define H_DEREG_BCMC =A0 =A0 =A0 =A0 =A0 0x268
> +#define H_REGISTER_HEA_RPAGES =A00x26C
> +#define H_DISABLE_AND_GET_HEA =A00x270
> +#define H_GET_HEA_INFO =A0 =A0 =A0 =A0 0x274
> +#define H_ADD_CONN =A0 =A0 =A0 =A0 =A0 =A0 0x284
> +#define H_DEL_CONN =A0 =A0 =A0 =A0 =A0 =A0 0x288

I  guess these should go to include/asm-powerpc/hvcall.h instead.

	Arnd <><
