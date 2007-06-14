Return-Path: <sshtylyov@ru.mvista.com>
Message-ID: <4671390D.1060606@ru.mvista.com>
Date: Thu, 14 Jun 2007 16:48:13 +0400
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: Create "rom" (MTD) device prpmc2800
References: <7878cf1aec340b976b90b86b9e83bf18@kernel.crashing.org>	<20070612044246.GC4198@localhost.localdomain>
	<9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
In-Reply-To: <9fbd7a7f5cdde58768569ab23c7aec7c@kernel.crashing.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>,
	David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>So, what you're suggesting is a subnode for each described partition?

> I'm saying this is a reasonable way to describe the regions
> of flash the firmware itself cares about.

> This isn't anything new; it is done like this on some
> Apple systems, for example.

    First you're saying that nodes should correspont to *real* devices, then 
it turns out that there have been precedents for the nodes corresponding to 
completely virtual entities? ;-)

>>Seems an awfully verbose way of going about it,

> Not verbose, but flexible, and in line with everything

    Yes, I'd agree about more flexibility...

> else about the device tree.

    How about your earlier arguments against the representation of flashes?

>>and I don't see what
>>it buys us over the partitions/partition-names pair of properties.

> It is extensible.  It makes parsing trivial.  It

    Excellent -- previously my arguments about more simplicity for 
representing  flash itself were sent to /dev/null.

> represents a flash partition in a way similar to how
> a "whole" flash device is represented.

    Except it's not a device. :-)

> Segher

WBR, Sergei
