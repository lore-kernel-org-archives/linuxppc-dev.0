Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <1184165950.24563.11.camel@localhost.localdomain>
References: <1184135957.23157.6.camel@localhost.localdomain>
	<F63DA339-F5B1-40CB-B05E-9E40BEC3992E@kernel.crashing.org>
	<1184165950.24563.11.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <798CBDF4-B74E-47A2-8026-C76DE4E5F40A@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] Fix mpc7448hpc2 tsi108 device_type bug
Date: Wed, 11 Jul 2007 19:51:05 +0200
To: Zang Roy-r61911 <tie-fei.zang@freescale.com>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> Fix mpc7448hpc2 tsi108 device_type bug.
>>> Wrong device type will break the board startup.
>>
>>> -             device_type = "tsi108-bridge";
>>> +             device_type = "tsi-bridge";
>>
>> The OS code shouldn't use "device_type" at all for this,
>> but "compatible" instead.  You might want to fix that.
> I can understand you. Should we separate it into two steps:
> (1) Fix the bug in old style to ensure the  board work. I can see  
> other
> code in kernel tree will be affected by removing "device_type".
> (2) Using compatible instead of device_type for all associated boards
> and code.

Yes, good plan.

>> This patch is fine until you do of course.
> That is fine.

This is your step (1) :-)


Segher
