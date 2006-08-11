Return-Path: <master@toliqdoi.de>
Received: from mtagate4.de.ibm.com (mtagate4.de.ibm.com [195.212.29.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate4.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 2533467B6F
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 19:50:04 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate4.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7B9o0KO187856
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:50:00 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7B9rg3D143556
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:53:42 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7B9nxnk007732
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 11:49:59 +0200
Message-ID: <44DC52C7.9020703@toliqdoi.de>
Date: Fri, 11 Aug 2006 11:49:59 +0200
From: Thomas Klein <master@toliqdoi.de>
MIME-Version: 1.0
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] ehea: PPC - New hcall opcode defines
References: <44DB4B38.9030502@de.ibm.com>
	<20060811012044.1c8fcd20.sfr@canb.auug.org.au>
In-Reply-To: <20060811012044.1c8fcd20.sfr@canb.auug.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: tklein@de.ibm.com, themann@de.ibm.com, Thomas Klein <osstklei@de.ibm.com>,
	linuxppc-dev@ozlabs.org, raisch@de.ibm.com, meder@de.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Rothwell wrote:
> On Thu, 10 Aug 2006 17:05:28 +0200 Thomas Klein <osstklei@de.ibm.com> wrote:
>   
>> diff -Nurp -X dontdiff linux-2.6.18-rc4/include/asm-powerpc/hvcall.h patched_kernel/include/asm-powerpc/hvcall.h
>> --- linux-2.6.18-rc4/include/asm-powerpc/hvcall.h	2006-08-06 11:20:11.000000000 -0700
>> +++ patched_kernel/include/asm-powerpc/hvcall.h	2006-08-10 06:26:33.018907062 -0700
>> @@ -201,6 +201,19 @@
>>   #define H_JOIN			0x298
>>   #define H_VASI_STATE            0x2A4
>>   #define H_ENABLE_CRQ		0x2B0
>> +#define H_ALLOC_HEA_RESOURCE	0x278
>> +#define H_MODIFY_HEA_QP		0x250
>> +#define H_QUERY_HEA_QP		0x254
>> +#define H_QUERY_HEA		0x258
>> +#define H_QUERY_HEA_PORT	0x25C
>> +#define H_MODIFY_HEA_PORT	0x260
>> +#define H_REG_BCMC		0x264
>> +#define H_DEREG_BCMC		0x268
>> +#define H_REGISTER_HEA_RPAGES	0x26C
>> +#define H_DISABLE_AND_GET_HEA	0x270
>> +#define H_GET_HEA_INFO		0x274
>> +#define H_ADD_CONN		0x284
>> +#define H_DEL_CONN		0x288
>>     
>
> This patch appears to be whitespace damaged and it would be preferable if
> the new defines were in there correct places in numerical order.
>
> Thanks.
>
>   
I agree. I posted a new patch 
(http://ozlabs.org/pipermail/linuxppc-dev/2006-August/025032.html)
where I rearranged the defines to fit in the numerical order with the 
other defines.

The whitespaces are not damaged although they appear to be. This is due 
to the usage of
TAB characters to align the hex values. TAB characters are used in the 
whole file to align the
numerical values. I applied the patch and the result looks okay.
