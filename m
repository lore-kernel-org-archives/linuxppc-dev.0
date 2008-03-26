Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 213AFDEAD7
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Mar 2008 02:24:46 +1100 (EST)
Message-ID: <47EA6B11.7050804@ru.mvista.com>
Date: Wed, 26 Mar 2008 18:26:09 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 1/2] [MTD] Add support for RAM & ROM mappings in
	the	physmap_of MTD driver.
References: <200803261344.03438.laurentp@cse-semaphore.com>
	<346860fa1e8a75a4a89e260011690659@kernel.crashing.org>
In-Reply-To: <346860fa1e8a75a4a89e260011690659@kernel.crashing.org>
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

>>      {
>> +        .compatible    = "physmap-ram",
>> +        .data        = (void *)"map_ram",
>> +    },
>> +    {
>> +        .compatible    = "physmap-rom",
>> +        .data        = (void *)"map_rom",
>> +    },

> Why the cast?  It's redundant afaics.

   To be in line with the surrounding code...

> Segher

WBR, Sergei
