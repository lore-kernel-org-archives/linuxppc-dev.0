Return-Path: <tnt@246tNt.com>
Message-ID: <460CF85C.6040404@246tNt.com>
Date: Fri, 30 Mar 2007 13:45:32 +0200
From: Sylvain Munaut <tnt@246tNt.com>
MIME-Version: 1.0
To: Hoang-Nam Nguyen <HNGUYEN@de.ibm.com>
Subject: Re: [PATCH 10/10] powerpc: Add uevent handler for ibmebus
References: <OFD88782F1.00A0B5EA-ONC12572AE.003EB9E2-C12572AE.003EF069@de.ibm.com>
In-Reply-To: <OFD88782F1.00A0B5EA-ONC12572AE.003EB9E2-C12572AE.003EF069@de.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Linux PPC Dev ML <linuxppc-dev@ozlabs.org>, Olaf Hering <olaf@aepfle.de>,
	Paul Mackerras <paulus@samba.org>,
	linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hoang-Nam Nguyen wrote:
> linuxppc-dev-bounces+hnguyen=de.ibm.com@ozlabs.org wrote on 29.03.2007
> 16:46:23:
>
>   
>> On Mon, Feb 12, Sylvain Munaut wrote:
>>
>>     
>>>  arch/powerpc/kernel/ibmebus.c |   16 ++++++++++++++++
>>>       
>>> +   if (ebus_dev==ibmebus_bus_device)   /* filter dummy root device */
>>>       
>> Does that compile for you?
>> ibmebus_bus_device should be &ibmebus_bus_device
>>     
> Can you tell me from which code base you're seeing this?
> Is above change from Sylvain? I looked at Joachim's recent patches and did
> not find that code line.
> Thanks
> Nam
>   
Yes it's a line my pacthe adds.

But IIRC, Joachim's patch remove the dummy root device which means
that's use less.

In fact my whole [PATCH 10/10]  should not be used and Joachim's version
is the good one.


    Sylvain
