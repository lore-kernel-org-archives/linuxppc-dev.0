Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070510233747.GC27188@localhost.localdomain>
References: <20070510200237.GA19756@mag.az.mvista.com>
	<20070510200859.GL19756@mag.az.mvista.com>
	<20070510233747.GC27188@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c3bcf08004bf1d35292b8a5661e6a6e6@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 11/13] powerpc: Add DTS file for the Motorola PrPMC2800
	platform
Date: Sat, 12 May 2007 13:59:09 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> +			partition-names = "FW Image A\0FW Config Data\0Kernel 
>> Image\0Filesystem\0FW Image B";
>
> dtc now supports the syntax:
> 	partition-names = "FW Image A", "FW Config Data", ...
> for multi-string properties to make this sort of thing less ugly.

Nice!  Can you also concatenate different property
encodings that way?  Like,

	slot-names = <5>, "Slot A", "Slot C";

or something like that?


Segher
