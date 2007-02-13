Return-Path: <timur@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 911D5DDF4B
	for <linuxppc-dev@ozlabs.org>; Wed, 14 Feb 2007 04:20:51 +1100 (EST)
Message-ID: <45D1F36A.4030402@freescale.com>
Date: Tue, 13 Feb 2007 11:20:42 -0600
From: Timur Tabi <timur@freescale.com>
MIME-Version: 1.0
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: delete boot-cpu and chosen nodes from all DTS
	files
References: <11713852392294-git-send-email-timur@freescale.com>
	<1712A11E-2F9F-441E-97E2-6FE82ED5A539@kernel.crashing.org>
In-Reply-To: <1712A11E-2F9F-441E-97E2-6FE82ED5A539@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala wrote:
> 
> On Feb 13, 2007, at 10:47 AM, Timur Tabi wrote:
> 
>> The 'linux,boot-cpu' property and the 'chosen' node do not belong in the
>> DTS file, because U-Boot creates these entries in the device tree when
>> it boots linux.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
> 
> Is there some harm is having them set in the .dts?

Well, I don't think a DTS should contain a property that isn't going to be used. 
  It might convince people that the property belongs there.

The 'chosen' section is absent from all but one DTS for the same reason.

> I can see 'linux,boot-cpu' may vary on a SMP, but the majority of .dts's 
> are for uniproc's

U-Boot sets it, so whatever the DTS contains is ignored.

-- 
Timur Tabi
Linux Kernel Developer @ Freescale
