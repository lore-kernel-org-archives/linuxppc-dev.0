Return-Path: <wolfgang.reissnegger@xilinx.com>
Date: Thu, 24 May 2007 08:42:08 -0700
From: Wolfgang Reissnegger <wolfgang.reissnegger@xilinx.com>
MIME-Version: 1.0
To: Andrei Konovalov <akonovalov@ru.mvista.com>
Subject: Re: Xilinx git tree at source.mvista.com
References: <46555294.6040104@ru.mvista.com> <465561A4.9020403@dlasys.net>
	<46558E54.80909@ru.mvista.com>
In-Reply-To: <46558E54.80909@ru.mvista.com>
Content-Type: text/plain; charset=us-ascii
Message-Id: <20070524154211.169C7AE8051@mail10-fra.bigfish.com>
Cc: linuxppc-dev@ozlabs.org, "David H. Lynch Jr." <dhlii@dlasys.net>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Andrei, David,

It's great to hear that Andrei's git tree is active again.

As you might have heard, Xilinx is in the process of setting up a git
tree as well. Right now we are waiting for the new hosting machines to
be installed. We should get those machines up and running shortly
(within a couple weeks).

Currently the tree is based on mainline and adds support for MicroBlaze.
I also intent to merge Grant Likely's virtex-dev branch, the framebuffer
patch and the various other contributions that are out there.

We are also in the process of changing our internal coding guidelines to
match the common Linux style (e.g. u32, u16 types, 8 char wide (tab)
indentation, curly brace location etc) to make it easier to integrate
code into the kernel and push it upstream.

I'll send an update once we have the server up and running.

Thanks,
   Wolfgang

Andrei Konovalov wrote:
> Hi David,
> 
> David H. Lynch Jr. wrote:
>> Andrei Konovalov wrote:
>>> Hello,
>>>
>>> My Xilinx Virtex Development tree is now alive again.
>>>
>>> Please use the dev branch (master is just the ko copy):
>>> http://source.mvista.com/git/gitweb.cgi?p=linux-xilinx-26.git;a=shortlog;h=dev
>>> Currently it has a patch to enable the framebuffer
>>> on ML403 and ML300 plus TEMAC driver that uses
>>> the PHY lib (FIFO mode support only).
>>> The TEMAC driver is work in progress.
>>> In the queue are SGDMA TEMAC support, and SPI driver
>>> (master only).
>>>
>>> My concern is that the TEMAC driver uses the "level 1 drivers" from EDK 9.1.
>>> The comments / opinions on how to get this driver (not the current incomplete
>>> version of course) accepted into the ko tree are very welcomed.
>>>   
>> I have an almost working FIFO TEMAC driver. It is similarly based.
>> it started out based on the Trek webserver sample
> 
> Is this a reference design by Xilinx? Linux based or standalone?
> 
>> I spent probably 3-4 days de-EDKing it into something that fit into a
>> single source and was closer to ko norms.
>> It is based on approximately the EDK 8.1 stuff. You are welcome to it,
>> if it could be helpful in anyway.
>> I am all for getting an acceptable driver into the ko tree.
> 
> You could post your driver to the list when you think it is in good enough shape.
> If your driver is based on the linux TEMAC driver from EDK, it shouldn't
> be very different from my version (my added value is mostly replacing the
> custom PHY code with the PHY lib stuff). Then we could merge our drivers (or
> whatever would make sense).
> 
> I would be interested to have a look at your current code just to see
> how much has it cost to "de-EDK" the FIFO part. You could email me
> your (even not quite working) driver privately if you want.
> 
> 
> Thanks,
> Andrei
> 
> _______________________________________________
> Linuxppc-embedded mailing list
> Linuxppc-embedded@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-embedded
> 
