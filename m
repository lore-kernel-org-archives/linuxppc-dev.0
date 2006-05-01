Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5775F67B8C
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 05:52:32 +1000 (EST)
In-Reply-To: <1146512732.24239.34.camel@cashmere.sps.mot.com>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Date: Mon, 1 May 2006 14:52:23 -0500
To: Jon Loeliger <jdl@freescale.com>
Cc: Jon Loeliger <jdl@jdl.com>,
	"linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[snip]

>> Try running a current .dts through cpp today.  You will get errors  
>> like:
>>
>> oftree.dts:15:3: error: invalid preprocessing directive #address
>
>> Because of props like:
>>
>>        #cpus = <1>;
>>        #address-cells = <1>;
>>        #size-cells = <0>;
>>
>> If these used some other symbol instead of '#' cpp will be happy and
>> we can use it to create macros for us.
>
> Yeah, we're not going to be able to change those; they
> are "By The Book".

By what book?  It would seem to me that BNF for dtc is completely  
under our control and if we want to change it we can.  I understand  
that there is some correspondence to Open Firmware, but it seems that  
if its people are ok with the dts format changing that's a lot easier  
than implementing tons of support in dtc for features that cpp gives us.

[I'm also guessing no one's really got time to go and implement these  
features in dtc]

> Instead, we'll have to make the lexical analysis conscious
> of something like a <newline> context sensitive token or so.
> Or throw some flag to cpp to not emit location markers.

- kumar
