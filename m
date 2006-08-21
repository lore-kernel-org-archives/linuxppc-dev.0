Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 7257867B76
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 19:53:37 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7L9rWEe145280
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 09:53:32 GMT
Received: from d06av02.portsmouth.uk.ibm.com (d06av02.portsmouth.uk.ibm.com
	[9.149.37.228])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7L9tSG9136018
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:55:28 +0100
Received: from d06av02.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av02.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7L9rV5I018440
	for <linuxppc-dev@ozlabs.org>; Mon, 21 Aug 2006 10:53:32 +0100
Message-ID: <44E9829B.7010503@de.ibm.com>
Date: Mon, 21 Aug 2006 11:53:31 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Stephen Hemminger <shemminger@osdl.org>
Subject: Re: [2.6.19 PATCH 4/7] ehea: ethtool interface
References: <200608181333.23031.ossthema@de.ibm.com>	<20060818140506.GC5201@martell.zuzino.mipt.ru>	<44E5DFA6.7040707@de.ibm.com>
	<20060818104547.5ad1352f@localhost.localdomain>
In-Reply-To: <20060818104547.5ad1352f@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev@vger.kernel.org, linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>, Alexey Dobriyan <adobriyan@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Stephen Hemminger wrote:
> On Fri, 18 Aug 2006 17:41:26 +0200
> Thomas Klein <osstklei@de.ibm.com> wrote:
> 
>> Hi Alexey,
>>
>> first of all thanks a lot for the extensive review.
>>
>>
>> Alexey Dobriyan wrote:
>>>> +	u64 hret = H_HARDWARE;
>>> Useless assignment here and everywhere.
>>>
>> Initializing returncodes to errorstate is a cheap way to prevent
>> accidentally returning (uninitalized) success returncodes which
>> can lead to catastrophic misbehaviour.
> 
> That is old thinking. Current compilers do live/dead analysis
> and tell you about this at compile time which is better than relying
> on default behavior at runtime.

Understood. I reworked the returncode handling and removed the
unnecessary initializations.

Thanks for pointing this out.

Thomas
