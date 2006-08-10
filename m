Return-Path: <osstklei@de.ibm.com>
Received: from mtagate5.de.ibm.com (mtagate5.de.ibm.com [195.212.29.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate5.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 36AFC67A3F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 01:13:00 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate5.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7AFCuAW089742
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 15:12:56 GMT
Received: from d12av01.megacenter.de.ibm.com (d12av01.megacenter.de.ibm.com
	[9.149.165.212])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7AFGcEF156634
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 17:16:38 +0200
Received: from d12av01.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av01.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7AFCuJd024331
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 17:12:56 +0200
Message-ID: <44DB4CF7.9080905@de.ibm.com>
Date: Thu, 10 Aug 2006 17:12:55 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Arnd Bergmann <arnd.bergmann@de.ibm.com>
Subject: Re: [PATCH 2/6] ehea: pHYP interface
References: <44D99F1A.4080905@de.ibm.com>
	<200608091514.46861.arnd.bergmann@de.ibm.com>
In-Reply-To: <200608091514.46861.arnd.bergmann@de.ibm.com>
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Wednesday 09 August 2006 10:38, Jan-Bernd Themann wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea_hcall.h 1969-12-31 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/ehea_hcall.h        2006-08-08 23:59:38.111462960 -0700
>> @@ -0,0 +1,52 @@
>
>> +
>> +/**
>> + * This file contains HCALL defines that are to be included in the appropriate
>> + * kernel files later
>> + */
>> +
>> +#define H_ALLOC_HEA_RESOURCE   0x278
>> +#define H_MODIFY_HEA_QP        0x250
>> +#define H_QUERY_HEA_QP         0x254
>> +#define H_QUERY_HEA            0x258
>> +#define H_QUERY_HEA_PORT       0x25C
>> +#define H_MODIFY_HEA_PORT      0x260
>> +#define H_REG_BCMC             0x264
>> +#define H_DEREG_BCMC           0x268
>> +#define H_REGISTER_HEA_RPAGES  0x26C
>> +#define H_DISABLE_AND_GET_HEA  0x270
>> +#define H_GET_HEA_INFO         0x274
>> +#define H_ADD_CONN             0x284
>> +#define H_DEL_CONN             0x288
>
> I  guess these should go to include/asm-powerpc/hvcall.h instead.
>
>       Arnd <><

We posted a separate patch for hvcall.h (http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025000.html).
As soon as this patch is accepted we'll remove the ehea_hcall.h headerfile.
