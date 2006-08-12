Return-Path: <osstklei@de.ibm.com>
Received: from mtagate2.de.ibm.com (mtagate2.de.ibm.com [195.212.29.151])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 6DD8A67C02
	for <linuxppc-dev@ozlabs.org>; Sun, 13 Aug 2006 02:40:19 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate2.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7CGeEon045536
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 16:40:14 GMT
Received: from d12av02.megacenter.de.ibm.com (d12av02.megacenter.de.ibm.com
	[9.149.165.228])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7CGhxIL125498
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 18:43:59 +0200
Received: from d12av02.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av02.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7CGeEDt016920
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Aug 2006 18:40:14 +0200
Message-ID: <44DE046D.2050304@de.ibm.com>
Date: Sat, 12 Aug 2006 18:40:13 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Anton Blanchard <anton@samba.org>, Jan-Bernd Themann <themann@de.ibm.com>
Subject: Re: [PATCH 4/6] ehea: header files
References: <44D99F56.7010201@de.ibm.com> <20060811220728.GI479@krispykreme>
In-Reply-To: <20060811220728.GI479@krispykreme>
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

Anton Blanchard wrote:
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/ehea.h	1969-12-31 
>>     
>
>   
>> +extern void exit(int);
>>     
>
> Should be able to remove that prototype :) 
>
> Anton
>   
Indeed :-) It's gone.

Thomas
