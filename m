Return-Path: <osstklei@de.ibm.com>
Received: from mtagate6.de.ibm.com (mtagate6.de.ibm.com [195.212.29.155])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate6.de.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id DD2EB67B73
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 23:25:16 +1000 (EST)
Received: from d12nrmr1607.megacenter.de.ibm.com
	(d12nrmr1607.megacenter.de.ibm.com [9.149.167.49])
	by mtagate6.de.ibm.com (8.13.7/8.13.7) with ESMTP id k7IDPCBA075034
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 13:25:12 GMT
Received: from d12av04.megacenter.de.ibm.com (d12av04.megacenter.de.ibm.com
	[9.149.165.229])
	by d12nrmr1607.megacenter.de.ibm.com (8.13.6/8.13.6/NCO v8.1.1) with
	ESMTP id k7IDT6sd107280
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:29:06 +0200
Received: from d12av04.megacenter.de.ibm.com (loopback [127.0.0.1])
	by d12av04.megacenter.de.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7IDPBCl004548
	for <linuxppc-dev@ozlabs.org>; Fri, 18 Aug 2006 15:25:12 +0200
Message-ID: <44E5BFB7.4000400@de.ibm.com>
Date: Fri, 18 Aug 2006 15:25:11 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Arjan van de Ven <arjan@infradead.org>
Subject: Re: [2.6.19 PATCH 3/7] ehea: queue management
References: <200608181331.19501.ossthema@de.ibm.com>
	<1155903451.4494.168.camel@laptopd505.fenrus.org>
In-Reply-To: <1155903451.4494.168.camel@laptopd505.fenrus.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Christoph Raisch <raisch@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arjan van de Ven wrote:
>> +	queue->queue_length = nr_of_pages * pagesize;
>> +	queue->queue_pages = vmalloc(nr_of_pages * sizeof(void *));
> 
> 
> wow... is this really so large that it warrants a vmalloc()???

Agreed: Replaced with kmalloc()

Regards
Thomas
