Return-Path: <minyard@acm.org>
Received: from mta14.adelphia.net (mta14.mail.adelphia.net [68.168.78.137])
	by ozlabs.org (Postfix) with ESMTP id E27F367C2C
	for <linuxppc-dev@ozlabs.org>; Sat,  9 Dec 2006 06:14:33 +1100 (EST)
Message-ID: <45799E15.1030004@acm.org>
Date: Fri, 08 Dec 2006 11:17:09 -0600
From: Corey Minyard <minyard@acm.org>
MIME-Version: 1.0
To: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [Openipmi-developer] [patch 0/1] ipmi: add autosensing of ipmi
	device on powerpc using device-tree
References: <20061207172259.64168f8c@localhost>	<17784.46252.935.759285@cargo.ozlabs.ibm.com>
	<200612081504.15471.arnd@arndb.de>
In-Reply-To: <200612081504.15471.arnd@arndb.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, openipmi-developer@lists.sourceforge.net,
	Paul Mackerras <paulus@samba.org>, Christian Krafft <krafft@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Arnd Bergmann wrote:
> On Friday 08 December 2006 01:41, Paul Mackerras wrote:
>   
>> Christian Krafft writes:
>>
>>     
>>> the patch I'll send, adds of_device support to the ipmi_si module.
>>> Having the correct device-tree entries, the ipmi module can be loaded without
>>> specifying the resources as module parameters.
>>>       
>> Which powerpc-based machines have IPMI?
>>     
>
> This particular one is for an upcoming product, benh knows which one this
> is for. The JS21 blade already has an IPMI controller, though that is
> hidden behind the hypervisor, see 
> http://www-03.ibm.com/systems/bladecenter/js21/specs.html.
>   
Also, all ATCA  powerpc boards have IPMI.

-Corey
