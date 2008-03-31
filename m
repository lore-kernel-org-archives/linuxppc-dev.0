Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <b393df3f814388b5cd5ae2f3b2b7fd66@kernel.crashing.org>
References: <200803101606.39184.laurentp@cse-semaphore.com>
	<200803251914.24021.laurentp@cse-semaphore.com>
	<47EA4741.2050402@ru.mvista.com>
	<200803271013.32612.laurentp@cse-semaphore.com>
	<20080327100304.GC10397@localhost.localdomain>
	<7c44646510c3b98075de9aa57cad0bce@kernel.crashing.org>
	<18416.813.635397.559197@cargo.ozlabs.ibm.com>
	<56851566f85e117c42b078dd2d6a2028@kernel.crashing.org>
	<18416.13196.812280.794832@cargo.ozlabs.ibm.com>
	<b393df3f814388b5cd5ae2f3b2b7fd66@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <48caaa39ff4d6552a5bf994a2c306d59@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: OF compatible MTD platform RAM driver ?
Date: Mon, 31 Mar 2008 03:24:29 +0200
To: Segher Boessenkool <segher@kernel.crashing.org>
Cc: ben@simtec.co.uk, "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

[Removed linux-mtd from cc:]

>>> [*] It seems to me the longtrail workaround code in prom_init.c is
>>> incorrect though: it will match any node with name "memory" that
>>> doesn't have a device_type?
>>
>> It only matches on children of the root node,
>
> Oh okay, I misread that then.

...No, I did not.  prom_next_node() does a depth-first tree traversal.

>> Actually we could probably remove the longtrail stuff
>> now; I think mine has stopped working, and I only know of 2 others in
>> existence. :)
>
> I'll prepare a patch.

...Actually, that's a lot of code to rip out, and I can't test this at 
all,
so I'll have to pass on this.


Segher
