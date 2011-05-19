Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 0311AB6F80
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 19 May 2011 15:33:21 +1000 (EST)
Subject: Re: powerpc: mpc85xx regression since 2.6.39-rc2, one cpu core lame
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1305668416.2781.23.camel@pasglop>
Date: Thu, 19 May 2011 00:33:12 -0500
Message-Id: <7038D856-29A6-4D6C-A6DB-F4DB5256C6FA@kernel.crashing.org>
References: <20110517162827.GA16918@riccoc20.at.omicron.at>
	<1305668416.2781.23.camel@pasglop>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Richard Cochran <richardcochran@gmail.com>, linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On May 17, 2011, at 4:40 PM, Benjamin Herrenschmidt wrote:

> On Tue, 2011-05-17 at 18:28 +0200, Richard Cochran wrote:
>> Ben,
>> 
>> Recent 2.6.39-rc kernels behave strangely on the Freescale dual core
>> mpc8572 and p2020. There is a long pause (like 2 seconds) in the boot
>> sequence after "mpic: requesting IPIs..."
>> 
>> When the system comes up, only one core shows in /proc/cpuinfo. Later
>> on, lots of messages appear like the following:
>> 
>>   INFO: task ksoftirqd/1:9 blocked for more than 120 seconds.
>> 
>> I bisected [1] the problem to:
>> 
>>   commit c56e58537d504706954a06570b4034c04e5b7500
>>   Author: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>   Date:   Tue Mar 8 14:40:04 2011 +1100
>> 
>>       powerpc/smp: Create idle threads on demand and properly reset them
>> 
>> I don't see from that commit what had gone wrong. Perhaps you can
>> help resolve this?
> 
> Hrm, odd. Kumar, care to have a look ? That's what happens when you
> don't get me HW to test with :-)

I'm trying to work on it ;)

- k
