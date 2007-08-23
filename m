Return-Path: <dhlii@dlasys.net>
Received: from mx.dlasys.net (24.152.192.123.res-cmts.eph.ptd.net
	[24.152.192.123]) (using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 86DE5DDF4A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 23 Aug 2007 16:46:37 +1000 (EST)
Message-ID: <46CD2CAF.5040104@dlasys.net>
Date: Thu, 23 Aug 2007 02:43:59 -0400
From: "David H. Lynch Jr." <dhlii@dlasys.net>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@jdub.homelinux.org>
Subject: Re: [PATCH] Consolidate XILINX_VIRTEX board support
References: <20070806225642.7D72A7B005B@mail34-fra.bigfish.com>	<87vebryfrv.fsf@sleipner.barco.com>	<46C79E33.8090600@dlasys.net>
	<20070818205752.049d2bc6@vader.jdub.homelinux.org>
In-Reply-To: <20070818205752.049d2bc6@vader.jdub.homelinux.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed
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
>> arch/boot/simple/embed_config.c jusst seems to be a random collection
>> of board specific code anyway.
>> A giant case statement implimented with #ifdef's. It is just
>> screaming to be done some better way.

>>
>> You mean like a device tree?  ;)
>>
>> josh
>>     
Maybe, I am waiting to see somebody move something to device tree so 
that I can get a better grasp of what it is and how it works.
 From what little I know I think it is going to be very significant for 
my BSP - we are trying to use a single binary for alot of different
boards, or the same board with different firmware. From what I am 
gathering I can have the loader pass a device tree to the kernel
and the device tree will basically describe the hardware to the kernel.

Only at the moment I don't have the time to learn enough to attempt to 
lead the charge moving xilinx stuff to powerpc.

Is there a way to do this in small peices ?

It would be nice to end some of the debate on how to setup ppc/4xx for 
multiple xilinx targets and just get it over with and move to powerpc
device tree, ...
But I can't beat others up for what I can't find time for myself.


-- 
Dave Lynch 					  	    DLA Systems
Software Development:  				         Embedded Linux
717.627.3770 	       dhlii@dlasys.net 	  http://www.dlasys.net
fax: 1.253.369.9244 			           Cell: 1.717.587.7774
Over 25 years' experience in platforms, languages, and technologies too numerous to list.

"Any intelligent fool can make things bigger and more complex... It takes a touch of genius - and a lot of courage to move in the opposite direction."
Albert Einstein
