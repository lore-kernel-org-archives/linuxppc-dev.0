Return-Path: <albert_herranz@yahoo.es>
Received: from smtp126.mail.ukl.yahoo.com (smtp126.mail.ukl.yahoo.com
	[77.238.184.57]) by ozlabs.org (Postfix) with SMTP id 9AA20B7BCA
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 26 Nov 2009 04:07:29 +1100 (EST)
Message-ID: <4B0D644E.3070103@yahoo.es>
Date: Wed, 25 Nov 2009 18:07:26 +0100
From: Albert Herranz <albert_herranz@yahoo.es>
MIME-Version: 1.0
To: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [RFC PATCH 09/19] powerpc: gamecube/wii: udbg support for usbgecko
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
	<73FCDEB3-3C1D-41F8-9CC3-D28D404E560B@kernel.crashing.org>
In-Reply-To: <73FCDEB3-3C1D-41F8-9CC3-D28D404E560B@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Segher Boessenkool wrote:
>>> Surely there is something called something like of_node_is_compatible()
>>> you can use here?  You already have the node pointer, there is no need
>>> to look at all other nodes.
>>>
>>
>> I see the point.
>> I didn't find of_node_is_compatible() but I'll look what's available
>> here.
> 
> int of_device_is_compatible(const struct device_node *device,
>                 const char *compat)
> 

Thanks. I'll pick that.

Cheers,
Albert
