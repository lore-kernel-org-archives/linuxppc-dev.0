Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 8F3B5679E7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 17:28:31 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7B7SRiR065388
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 07:28:27 GMT
Received: from d12av03.megacenter.de.ibm.com (d12av03.megacenter.de.ibm.com
	[9.149.165.213])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7B7W9M0114154
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:32:10 +0200
Received: from d12av03.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av03.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7B7SQEA020509
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 09:28:26 +0200
Message-ID: <44DC319A.10802@de.ibm.com>
Date: Fri, 11 Aug 2006 09:28:26 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com>
	<20060811000540.200CE67B6B@ozlabs.org>
	<20060811003204.GA6935@martell.zuzino.mipt.ru>
	<20060811004602.23EB467B64@ozlabs.org>
In-Reply-To: <20060811004602.23EB467B64@ozlabs.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Christoph Raisch <raisch@de.ibm.com>, linuxppc-dev@ozlabs.org,
	Marcus Eder <meder@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Michael Neuling wrote:
>>>> +static inline u32 map_swqe_size(u8 swqe_enc_size)
>>>> +{
>>>> +	return 128 << swqe_enc_size;
>>>> +}		      ^
>>>> +		      |
>>>> +static inline u32|map_rwqe_size(u8 rwqe_enc_size)
>>>> +{		      |
>>>> +	return 128 << rwqe_enc_size;
>>>>         
>> 		      ^
>>     
>>>> +}		      |
>>>>         
>>> 		      |
>>> Snap!  These are ide|tical...
>>>       
>> 		      |
>> No, they aren't. -----+
>>     
>
> Functionally identical.
>
> Mikey
>
>   
Agreed. Functions were replaced by a single map_wqe_size() function.

Thomas
