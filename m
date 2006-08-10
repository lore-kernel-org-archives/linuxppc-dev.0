Return-Path: <osstklei@de.ibm.com>
Received: from mtagate1.uk.ibm.com (mtagate1.uk.ibm.com [195.212.29.134])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate1.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 75CAE67BF7
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 01:06:58 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate1.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7AF6pcm073474
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 15:06:51 GMT
Received: from d06av01.portsmouth.uk.ibm.com (d06av01.portsmouth.uk.ibm.com
	[9.149.37.212])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7AF8eni138170
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 16:08:40 +0100
Received: from d06av01.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av01.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7AF6oq6020850
	for <linuxppc-dev@ozlabs.org>; Thu, 10 Aug 2006 16:06:51 +0100
Message-ID: <44DB4B8A.60006@de.ibm.com>
Date: Thu, 10 Aug 2006 17:06:50 +0200
From: Thomas Klein <osstklei@de.ibm.com>
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
Subject: Re: [PATCH 5/6] ehea: makefile
References: <44D99F74.1000704@de.ibm.com>
	<20060809095047.GA11555@mars.ravnborg.org>
In-Reply-To: <20060809095047.GA11555@mars.ravnborg.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Thomas Klein <osstklei@de.ibm.com>, linux-ppc <linuxppc-dev@ozlabs.org>,
	Christoph Raisch <raisch@de.ibm.com>, Marcus Eder <meder@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Sam Ravnborg wrote:
> On Wed, Aug 09, 2006 at 10:40:20AM +0200, Jan-Bernd Themann wrote:
>   
>> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>>
>>
>>  drivers/net/ehea/Makefile |    7 +++++++
>>  1 file changed, 7 insertions(+)
>>
>>
>>
>> --- linux-2.6.18-rc4-orig/drivers/net/ehea/Makefile	1969-12-31 
>> 16:00:00.000000000 -0800
>> +++ kernel/drivers/net/ehea/Makefile	2006-08-08 23:59:38.083467216 -0700
>> @@ -0,0 +1,7 @@
>> +#
>> +# Makefile for the eHEA ethernet device driver for IBM eServer System p
>> +#
>> +
>> +ehea_mod-objs = ehea_main.o ehea_phyp.o ehea_qmr.o ehea_ethtool.o 
>> ehea_phyp.o
>> +obj-$(CONFIG_EHEA) += ehea_mod.o
>> +
>>     
>
> Using -objs is deprecated, please use ehea_mod-y.
> This needs to be documented and later warned upon which I will do soon.
>
> 	Sam
>   
Done. Will be included in next patch.
