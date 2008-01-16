Return-Path: <galak@kernel.crashing.org>
Message-Id: <704B937B-6154-401F-B5BE-6A139B14D86F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: David Gibson <david@gibson.dropbear.id.au>
In-Reply-To: <20080116000915.GA4283@localhost.localdomain>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v915)
Subject: Re: [PATCH] [POWERPC] bootwrapper: Add find_node_by_alias and
	dt_fixup_mac_address_by_alias
Date: Tue, 15 Jan 2008 22:12:04 -0600
References: <Pine.LNX.4.64.0801150934390.29314@blarg.am.freescale.net>
	<20080116000915.GA4283@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jan 15, 2008, at 6:09 PM, David Gibson wrote:

> On Tue, Jan 15, 2008 at 09:35:20AM -0600, Kumar Gala wrote:
>> Add the ability to set the mac address given the alias for the  
>> device.
>> Removes the need for having a linux,network-index property.
>>
>> ---
>>
>> in my git tree.
>
> Missing a Signed-off-by.  Otherwise looks good.

I'm not putting signed-off-by's on patches posted the list just for  
review.. thus they will not get picked up by anyone :)

- k
