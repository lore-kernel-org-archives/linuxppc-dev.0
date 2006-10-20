Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9D10567A3B
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Oct 2006 15:55:55 +1000 (EST)
In-Reply-To: <1161301280.10524.68.camel@localhost.localdomain>
References: <453771E5.4090808@bplan-gmbh.de>
	<20061019161855.GI6537@austin.ibm.com>
	<1161301280.10524.68.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <FA2AD5EF-06C9-454E-A1CB-0E7F61EDBB27@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] General CHRP/MPC5K2 Platform and drivers support - to
	comment
Date: Fri, 20 Oct 2006 00:55:50 -0500
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: sl@bplan-gmbh.de, linuxppc-dev@ozlabs.org, tnt@246tNt.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 19, 2006, at 6:41 PM, Benjamin Herrenschmidt wrote:

> On Thu, 2006-10-19 at 11:18 -0500, Linas Vepstas wrote:
>> On Thu, Oct 19, 2006 at 02:39:01PM +0200, Nicolas DET wrote:
>>> This 'big' patch adds support for CHRP/MPC52xx based platform. Here,
>>> this is the bPlan's Efika computer
>>> (http://www.bplan-gmbh.de/efika_spec_en.html)
>>>
>>> We know this patch is not totaly compliant with Documentation/ 
>>> CodingStyle/.
>>>
>>> We would like people to comment and review it.
>>
>> Can you send the patch unzipped, and not as an attachement?
>> This would make reviewing and commenting much easier.
>
> It's too big for the list.

I think the reasons its to big is it includes patches for platform,  
uart, and enet drivers on 52xx.

- k
