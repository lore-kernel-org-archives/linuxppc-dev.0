Return-Path: <segher@kernel.crashing.org>
In-Reply-To: <20070803064328.GC14456@localhost.localdomain>
References: <20070627065335.GD11191@localhost.localdomain>
	<20070627071008.GA30648@localhost.localdomain>
	<b1bc50e84cd3f8009eca2b470bea026f@kernel.crashing.org>
	<20070718013110.GA18251@localhost.localdomain>
	<505C0D97-FF0D-4E7F-B988-88894F629FD2@kernel.crashing.org>
	<20070803064328.GC14456@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <781f6c77f5051dffb7822685b0dc8e4a@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 3/3] First cut at PReP support for arch/powerpc
Date: Mon, 6 Aug 2007 21:37:25 +0200
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>> It seems to me a flat device tree could leave out all those
>> properties that can be derived from the PVR (except for the
>> few that are really useful for bootloaders and such -- cache
>> line size, 64-bit-or-not, what kind of MMU).  Linux doesn't
>> use it anyway.  Existing DTSs already leave away most.
>
> I agree, ditched them from my dts.

It's good to have consensus :-)

Is this documented already?

>> If PReP requires a specific programming model for the PCI
>> host bridge, that would be fine.  But then compatible =
>> "prep-pci-bridge" or such, not just "prep"; everything on
>> your board is "prep", it would make matching a bit hard ;-)
>
> Well... I'm rather unclear on how much PReP requires of the PCI
> bridge.  I thought what I'd coded was based on what appeared to be
> hard assumptions in prep_pci.c, but now I'm hearing that this won't
> cover all PReP machines, so I'm really not sure.

Also, even if the current kernels assume certain hardware, that
doesn't mean you can do the same in the device tree.


Segher
