Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 74B49DDE0A
	for <linuxppc-dev@ozlabs.org>; Wed, 31 Dec 2008 04:27:05 +1100 (EST)
Message-Id: <AD3CD240-2FA0-4EF2-A348-71E64EEB4484@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <ed82fe3e0812201927j2cf2786ag320e9ebd3b7c7954@mail.gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] powerpc: Update 8641hpcn dts file to match latest u-boot
Date: Tue, 30 Dec 2008 11:24:59 -0600
References: <1229724312-20406-1-git-send-email-beckyb@kernel.crashing.org>
	<ed82fe3e0812201927j2cf2786ag320e9ebd3b7c7954@mail.gmail.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Dec 20, 2008, at 9:27 PM, Timur Tabi wrote:

> On Fri, Dec 19, 2008 at 4:05 PM, Becky Bruce <beckyb@kernel.crashing.org 
> > wrote:
>> --- a/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>> +++ b/arch/powerpc/boot/dts/mpc8641_hpcn.dts
>> @@ -26,7 +26,7 @@
>>               serial1 = &serial1;
>>               pci0 = &pci0;
>>               pci1 = &pci1;
>> -               rapidio0 = &rapidio0;
>> +               /* rapidio0 = &rapidio0; */
>
> If you're going to leave commented-out code in the DTS, please add a
> comment here to explain why the code is commented-out and not just
> deleted.

There is a comment its just further down w/the actual rapidio node.

- k
