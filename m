Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C5EFCDDE2C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 01:05:46 +1000 (EST)
Message-ID: <47010CC4.7000204@garzik.org>
Date: Mon, 01 Oct 2007 11:05:40 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Jan-Bernd Themann <ossthema@de.ibm.com>
Subject: Re: [PATCH] ehea: DLPAR memory add fix
References: <200710011633.18305.ossthema@de.ibm.com>
	<470107D9.2040301@garzik.org>
	<200710011654.14067.ossthema@de.ibm.com>
In-Reply-To: <200710011654.14067.ossthema@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: Thomas Klein <tklein@de.ibm.com>, Jan-Bernd Themann <themann@de.ibm.com>,
	netdev <netdev@vger.kernel.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	linux-ppc <linuxppc-dev@ozlabs.org>, Christoph Raisch <raisch@de.ibm.com>,
	Marcus Eder <meder@de.ibm.com>, Stefan Roscher <stefan.roscher@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jan-Bernd Themann wrote:
> Hi,
> 
> On Monday 01 October 2007 16:44, Jeff Garzik wrote:
>> Jan-Bernd Themann wrote:
>>> Due to stability issues in high load situations the HW queue handling
>>> has to be changed. The HW queues are now stopped and restarted again instead
>>> of destroying and allocating new HW queues. 
>>>
>>> Signed-off-by: Jan-Bernd Themann <themann@de.ibm.com>
>> May I presume this is for 2.6.23?
>>
>> 	Jeff
> 
> no, the patch is build against 2.6.24 upstream (new NAPI interface).

OK, thanks.

Since we typically have two streams, the current bug-fix stream and the 
for-next-kernel stream, please indicate to which kernel/git tree your 
patch applies, in the future.
