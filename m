Return-Path: <segher@kernel.crashing.org>
Received: from mail-in-09.arcor-online.net (mail-in-09.arcor-online.net
	[151.189.21.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.arcor.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 01A1967A65
	for <linuxppc-dev@ozlabs.org>; Tue,  2 May 2006 10:17:30 +1000 (EST)
In-Reply-To: <1146526448.30710.70.camel@localhost.localdomain>
References: <5CA113BC-1614-4551-87E5-6926E14C2225@kernel.crashing.org>
	<1146512012.24239.28.camel@cashmere.sps.mot.com>
	<695BB790-1E64-4B53-91DD-7DD88305F201@kernel.crashing.org>
	<1146512732.24239.34.camel@cashmere.sps.mot.com>
	<55FD11DB-54AF-4284-9E9A-C313F4232105@kernel.crashing.org>
	<1146526448.30710.70.camel@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v749.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F2FFCB64-C013-4A0B-A954-9764E6C912FE@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: DTC/dts modifications
Date: Tue, 2 May 2006 02:17:24 +0200
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Jon Loeliger <jdl@jdl.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> By what book?  It would seem to me that BNF for dtc is completely
>> under our control and if we want to change it we can.  I understand
>> that there is some correspondence to Open Firmware, but it seems that
>> if its people are ok with the dts format changing that's a lot easier
>> than implementing tons of support in dtc for features that cpp  
>> gives us.
>
> What about just providing a way to escape them ? Something like \#  
> would
> do the trick

Nope, cpp won't eat that.


\#Segher
