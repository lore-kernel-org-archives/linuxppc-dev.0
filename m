Message-ID: <3E1D2F34.20908@intracom.gr>
Date: Thu, 09 Jan 2003 10:13:40 +0200
From: Pantelis Antoniou <panto@intracom.gr>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Boris Bezlaj <boris@bandit.kista.gajba.net>,
	linuxppc-dev@lists.linuxppc.org
Subject: Re: Status of linuxppc_2.5
References: <3E1BECD2.9060909@intracom.gr>	 <20030108173215.GA1002@bandit.kista.gajba.net> <1042049915.787.9.camel@zion.wanadoo.fr>
In-Reply-To: <1042049915.787.9.camel@zion.wanadoo.fr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Benjamin Herrenschmidt wrote:

>On Wed, 2003-01-08 at 18:32, Boris Bezlaj wrote:
>
>
>>On Wed, Jan 08, 2003 at 11:18:10AM +0200, Pantelis Antoniou wrote:
>>
>>
>>
>>>BTW, are there any gotchas, or anything
>>>I should pay attention moving
>>>from 2.4 -> 2.5?
>>>
>>>
>>AFAIK, you need the new module-init-tools for loading/unloading modules.
>>
>>I see there is a little patch for swim3 driver. Do you have any problems
>>with swim3 driver in 2.4 kernel when writing to floppy? What is the status
>>in v2.5?
>>
>
>What patch ? I'm interested ;)
>
>So far, swim3 in 2.5 is not up-to-date to new BIO semantics in 2.5. I've wanted
>to do that for some time now but didn't find time yet.
>
>Ben.
>
>
>
>
>
I'm sorry, the patch is just trivial stuff needed
to get it to compile. I don't even have hardware
that applies to swim3 driver. I just added the
include for the header and modified the call
to ide_unregister to use the new calling convention.

BTW ide_unregister was not exported in linux/ide.h
and so I added the prototype there. Maybe someone
should notify the maintainer of the IDE layer that
since this function is needed by the swim3 driver
it should be visible in the header?
Or we should use a new infrastructure?

As I mentioned since I don't have a power mac testing
system, I'm not willing to sacrifice my workstation
to the gods of 2.5 just yet.

What I want to do is to use 2.5 for my board which
uses a 8xx, and there I'm up against greater problems...
My major obstacle is the 8xx uart driver.

I'm not up to speed on 2.5 yet, but what
happened to DECLARE_TASK_QUEUE? Apparently alot of
things changed significantly.

Is there any document or whatever to help me
clean up the confusion?

Finally, if I am permitted to say, it appears that we are
a little behind in the 2.5 train. The release date
is getting closer, and I'm not sure that there
are any people using 2.5 in PPC systems.
IMHO we should pick up the pace a little bit.

Regards

Pantelis


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
