Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 3DD09DDEBD
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 27 Jun 2007 04:17:22 +1000 (EST)
Message-ID: <468153BF.6060204@ru.mvista.com>
Date: Tue, 26 Jun 2007 21:58:23 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: Katmai w/ DENX git - "init has generated signal 4" error
References: <OFBF408254.9B235C85-ON87257306.0057DC6C-85257306.0057F0B4@us.ibm.com>
	<1182877959.19501.17.camel@weaponx.rchland.ibm.com>
In-Reply-To: <1182877959.19501.17.camel@weaponx.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Tue, 2007-06-26 at 12:02 -0400, Stephen Winiecki wrote:
>   
>>> I'm using the Denx linux-2.6-denx.git repository with a Katmai board. I 
>>> want to boot off a disk (initialized w/ Debian 4.0).  I've installed a 
>>> Promise Ultra133 Tx2 IDE controller card in the PCI slot, and configured 
>>>       
>>> it in the kernel.    I boot this same disk w/ IDE card on other 4xx 
>>>       
>> boards 
>>     
>>> without a problem (Bamboo w/ Denx 4.1 for example).  I am getting an 
>>>       
>> error 
>>     
>>> "init has generated signal 4 but has no handler for it".
>>>       
>> I believe the problem may be due to lack of HW FP on the processor(?). 
>> Copying an embedded 440 RFS on disk works OK.
>>     
>
> Signal 4 is SIGILL, which could be returned for float instructions I
> suppose.  Try turning on CONFIG_MATH_EMULATION in your kernel config for
> Katmai and see if the problem goes away.
>
> josh
>
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
>   
Looks like 440SPe entry  is missing in the arch/ppc/kernel/cputable.c
Thanks.
