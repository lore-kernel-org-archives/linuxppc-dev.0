Return-Path: <galak@kernel.crashing.org>
Message-Id: <6584A045-0994-4CDB-B89B-EE5657147C9E@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080311003705.GH11559@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v919.2)
Subject: Re: [PATCH] [POWERPC] bootwrapper: Allow specifying of image physical
	offset
Date: Mon, 10 Mar 2008 23:19:24 -0500
References: <Pine.LNX.4.64.0803071055200.8522@blarg.am.freescale.net>
	<20080311003705.GH11559@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mar 10, 2008, at 7:37 PM, David Gibson wrote:

> On Fri, Mar 07, 2008 at 10:55:51AM -0600, Kumar Gala wrote:
>> Normally we assume kernel images will be loaded at offset 0. However
>> there are situations, like when the kernel itself is running at a  
>> non-zero
>> physical address, that we don't want to load it at 0.
>>
>> Allow the wrapper to take an offset.  We use this when building u- 
>> boot images.
>>
>> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
>
> Hrm.  It concerns me that with the patch as it stands,
> CONFIG_MEMORY_START looks like a fairly universal option, but it will
> only be respected on u-boot platforms (and only new u-boot, not cuboot
> at that).

Nothing stops anyone from submitting patches that makes it work for  
other platforms.  CONFIG_MEMORY_START is only of utility on book-e  
class machines at this point and from a Freescale point of view that's  
85xx and thus means u-boot.  IBM, AMCC, or a random Joe is free to  
submit patches to make it work on 44x. :)

- k
