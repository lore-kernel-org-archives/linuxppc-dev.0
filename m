Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 2F12DDDF35
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Oct 2008 03:05:43 +1100 (EST)
Message-Id: <1DA7FAFA-0708-4CFC-B721-B09A29F45B3F@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Jon Tollefson <kniht@linux.vnet.ibm.com>
In-Reply-To: <48EA31D5.70609@linux.vnet.ibm.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v929.2)
Subject: Re: [PATCH] properly reserve in bootmem the lmb reserved regions that
	cross numa nodes
Date: Mon, 6 Oct 2008 10:58:25 -0500
References: <48E23D6C.4030406@linux.vnet.ibm.com>
	<1222789675.13978.14.camel@localhost.localdomain>
	<7E5B6DFB-F9DE-4929-8A4F-8011BF817017@kernel.crashing.org>
	<48EA31D5.70609@linux.vnet.ibm.com>
Cc: Linux Memory Management List <linux-mm@kvack.org>,
	linuxppc-dev <linuxppc-dev@ozlabs.org>,
	Adam Litke <agl@linux.vnet.ibm.com>,
	Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Oct 6, 2008, at 10:42 AM, Jon Tollefson wrote:

> Kumar Gala wrote:
>> Out of interest how to do you guys represent NUMA regions of memory  
>> in
>> the device tree?
>>
>> - k
> Looking at the source code in numa.c I see at the start of
> do_init_bootmem() that parse_numa_properties() is called.  It  
> appears to
> be looking at memory nodes and getting the node id from it.  It gets  
> an
> associativity property for the memory node and indexes that array  
> with a
> 'min_common_depth' value to get the node id.
>
> This node id is then used to setup the active ranges in the
> early_node_map[].
>
> Is this what you are asking about?  There are others I am sure who  
> know
> more about it then I though.

I was wondering if this was documented anywhere (like in sPAPR)?

- k
