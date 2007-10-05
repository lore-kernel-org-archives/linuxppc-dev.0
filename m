Return-Path: <vbarshak@ru.mvista.com>
Received: from buildserver.ru.mvista.com (unknown [85.21.88.6])
	by ozlabs.org (Postfix) with ESMTP id 9BFA3DDE30
	for <linuxppc-dev@ozlabs.org>; Sat,  6 Oct 2007 04:37:46 +1000 (EST)
Message-ID: <47068433.7060803@ru.mvista.com>
Date: Fri, 05 Oct 2007 22:36:35 +0400
From: Valentine Barshak <vbarshak@ru.mvista.com>
MIME-Version: 1.0
To: benh@kernel.crashing.org
Subject: Re: [PATCH 5/6] PowerPC 440EPx: Sequoia board support
References: <20070730151628.GA5100@ru.mvista.com>	
	<200708030844.13895.sr@denx.de> <46B31352.1060503@ru.mvista.com>	
	<200708031425.19475.sr@denx.de> <1186144536.5981.5.camel@gruick>
In-Reply-To: <1186144536.5981.5.camel@gruick>
Content-Type: text/plain; charset=KOI8-R; format=flowed
Cc: linuxppc-dev@ozlabs.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt wrote:
>> Depends on interpretation. IIRC currently the same die is used for 440EPx and 
>> 440GRx. I could be wrong here though and it is just a bug in the chip. But 
>> anyway we should support this somehow. Could be that I missed this in the 
>> current 440GRx (Rainier) arch/ppc support too. I have to admit, that no 
>> clever solution comes to my mind right away though.
> 
> We can always come up with some kind of runtime detection, by turning on
> MSR:FP, issuing an fp instruction and catching the illegal instruction
> fault if any :-)
> 
> Ben.
> 
> 

Is it OK to workaround the GRX/EPX having the same PVR issue using 
device tree?
Say, check the PVR value and if we have 440EPx PVR, but 440GRX node in 
the device tree, fix the cputable entry and omit FPU initialization code.
Thanks,
Valentine.
