Return-Path: <pochini@denise.shiny.it>
Received: from denise.shiny.it (denise.shiny.it [194.20.232.1])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 02900DDDE5
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Mar 2007 09:59:29 +1100 (EST)
Date: Mon, 12 Mar 2007 23:48:21 +0100 (CET)
From: Giuliano Pochini <pochini@denise.shiny.it>
To: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: /sys/devices/system/cpu/cpuX/online are missing
In-Reply-To: <20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
Message-ID: <Pine.LNX.4.64.0703122337350.25919@denise.shiny.it>
References: <20070311222652.5ea40da1.pochini@shiny.it>
	<20070312085826.GA9985@osiris.boeblingen.de.ibm.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>



On Mon, 12 Mar 2007, Heiko Carstens wrote:

> On Sun, Mar 11, 2007 at 10:26:52PM +0100, Giuliano Pochini wrote:
>>
>>
>> Since 2.6.20 /sys/devices/system/cpu/cpuX/online isn't there anymore. The
>> directories exist, though. I also tested linux-2.6.21rc3. I had a look at the
>> archives and I found nothing about the removal of that file, which is still
>> documented in Documentation/cpu-hotplug.txt. I don't know if other
>> architectures are affected.
>>
>> $ uname -a
>> Linux Jay 2.6.20 #1 SMP Mon Feb 5 22:42:18 CET 2007 ppc 7455, altivec supported PowerMac3,6 GNU/Linux
>>
>> No cpusets. CONFIG_HOTPLUG_CPU=y
>
> Somebody inverted the logic when and if the 'online' attribute for cpu devices
> appear. See 72486f1f8f0a2bc828b9d30cf4690cf2dd6807fc.
> The fix for s390 is this: 6721f77810dfcb7cbf8e97be6fa43fe2740dd0aa.
> Looks like arch/ppc was left out as well.

I had a look at arch/powerpc/kernel/smp.c but I'm not familiar at all with 
those parts of the kernel. I'm cc'ing this message to linuxppc-dev.


--
Giuliano.
