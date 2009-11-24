Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id C0A5E10085A
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 25 Nov 2009 08:12:33 +1100 (EST)
In-Reply-To: <4B0C2115.3010006@yahoo.es>
References: <1258927311-4340-1-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-2-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-3-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-4-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-5-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-6-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-7-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-8-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-9-git-send-email-albert_herranz@yahoo.es>
	<1258927311-4340-10-git-send-email-albert_herranz@yahoo.es>
	<E6251558-8B55-4A7C-952C-4989D876C69A@kernel.crashing.org>
	<4B0C2115.3010006@yahoo.es>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <73FCDEB3-3C1D-41F8-9CC3-D28D404E560B@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
Date: Tue, 24 Nov 2009 22:19:16 +0100
To: Albert Herranz <albert_herranz@yahoo.es>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> +      If you say yes to this option, support will be included  
>>> for the
>>> +      USB Gecko adapter as an udbg console.
>>> +      The USB Gecko is a EXI to USB Serial converter that can be  
>>> plugged
>>> +      into a memcard slot in the Nintendo GameCube/Wii.
>>
>> Not "a" memcard slot, only the first one, you have it hardcoded.
>>
>
> No. It's not hardcoded in the code. It's specified in the device  
> tree source.
> The hardcoded one is just the early udbg, not the "normal" udbg.

Ah I misread the code then.

>> Surely there is something called something like  
>> of_node_is_compatible()
>> you can use here?  You already have the node pointer, there is no  
>> need
>> to look at all other nodes.
>>
>
> I see the point.
> I didn't find of_node_is_compatible() but I'll look what's  
> available here.

int of_device_is_compatible(const struct device_node *device,
                 const char *compat)


Segher
