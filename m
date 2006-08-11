Return-Path: <ossthema@de.ibm.com>
Received: from mtagate2.uk.ibm.com (mtagate2.uk.ibm.com [195.212.29.135])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mtagate2.uk.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 97F4167B86
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 23:42:44 +1000 (EST)
Received: from d06nrmr1407.portsmouth.uk.ibm.com
	(d06nrmr1407.portsmouth.uk.ibm.com [9.149.38.185])
	by mtagate2.uk.ibm.com (8.13.7/8.13.7) with ESMTP id k7BDgc2E058270
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=FAIL)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 13:42:39 GMT
Received: from d06av03.portsmouth.uk.ibm.com (d06av03.portsmouth.uk.ibm.com
	[9.149.37.213])
	by d06nrmr1407.portsmouth.uk.ibm.com (8.13.6/NCO/VER7.0) with ESMTP id
	k7BDiREf086310
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 14:44:27 +0100
Received: from d06av03.portsmouth.uk.ibm.com (loopback [127.0.0.1])
	by d06av03.portsmouth.uk.ibm.com (8.12.11.20060308/8.13.3) with ESMTP
	id k7BDgbYI010638
	for <linuxppc-dev@ozlabs.org>; Fri, 11 Aug 2006 14:42:37 +0100
Message-ID: <44DC804B.70609@de.ibm.com>
Date: Fri, 11 Aug 2006 15:04:11 +0200
From: Jan-Bernd Themann <ossthema@de.ibm.com>
MIME-Version: 1.0
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH 3/6] ehea: queue management
References: <44D99F38.8010306@de.ibm.com>
	<20060811000540.200CE67B6B@ozlabs.org>
In-Reply-To: <20060811000540.200CE67B6B@ozlabs.org>
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

Hi,

>
>> +#define EHEA_EQE_SM_MECH_NUMBER  EHEA_BMASK_IBM(48, 55)
>> +#define EHEA_EQE_SM_PORT_NUMBER  EHEA_BMASK_IBM(56, 63)
>> +
>> +struct ehea_eqe {
>> +	u64 entry;
>> +};
> 
> ehea_ege.. what is that and why a struct if only 1 item?  Comments
> please.  
> 

There are send / receive queue elements (ehea_swqe, ehea_rwqe),
completion queue elements (ehea_cqe) and event queue elements (ehea_eqe).
We introduced struct ehea_eqe to get a consistent description for all
queue elements.

Jan-Bernd
