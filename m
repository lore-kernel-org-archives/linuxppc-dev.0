Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id B108FDE53B
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:39:33 +1100 (EST)
Message-ID: <47EA6E88.5050109@ru.mvista.com>
Date: Wed, 26 Mar 2008 18:40:56 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
References: <200803101606.39184.laurentp@cse-semaphore.com>	<200803251823.32039.laurentp@cse-semaphore.com>	<DCEAAC0833DD314AB0B58112AD99B93B0427706A@ismail.innsys.innovsys.com>	<200803251914.24021.laurentp@cse-semaphore.com>
	<b06db7bb4932d14f8af9547abdfc9d0d@kernel.crashing.org>
In-Reply-To: <b06db7bb4932d14f8af9547abdfc9d0d@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: ben@simtec.co.uk, David Gibson <david@gibson.dropbear.id.au>,
	linux-mtd@lists.infradead.org, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:

>> - Using another device node with a compatible value set to 
>> "linear-ram" (or
>> something similar). This would support both volatile and non-volatile
>> devices, and a property could be added to specify if the device is 
>> volatile
>> or not.

> "memory-mapped-memory" perhaps :-)

> Or, just "memory".  Although that one might play havoc with some

    I'd suggest "ram" and "rom" then. Luckily the device trees don't contain 
binding for the real RAM chips yet. :-)

> not-quite-correct main memory probing code.

    You mean the there's parsers that search the "compatible" prop for 
"memory" as well as "device_type" prop?

> Segher

WBR, Sergei
