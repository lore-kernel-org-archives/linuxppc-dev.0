Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 9E5F2DDEE2
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Jan 2007 04:29:01 +1100 (EST)
In-Reply-To: <1168535981.18021.50.camel@localhost>
References: <20070111112504.37999DDF3E@ozlabs.org>
	<265e85080dc6d43eed2a42d06412eb92@kernel.crashing.org>
	<1168535981.18021.50.camel@localhost>
Mime-Version: 1.0 (Apple Message framework v623)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <477bb0db0bf2506a38d91d48a81b55c2@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH 4/7] MPIC MSI allocator
Date: Thu, 11 Jan 2007 18:27:12 +0100
To: will_schmidt@vnet.ibm.com
Cc: Greg Kroah-Hartman <greg@kroah.com>, linuxppc-dev@ozlabs.org,
	Paul Mackerras <paulus@samba.org>, Olof Johannsson <olof@lixom.net>,
	linux-pci@atrey.karlin.mff.cuni.cz
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>> +	/* Reserve source numbers we know are reserved in the HW */
>>> +	for (i = 0;   i < 8;   i++) __mpic_msi_reserve_hwirq(mpic, i);
>>> +	for (i = 42;  i < 46;  i++) __mpic_msi_reserve_hwirq(mpic, i);
>>> +	for (i = 100; i < 105; i++) __mpic_msi_reserve_hwirq(mpic, i);
>>
>> Coding style.  The ranges you reserve are a bit too wide,
>> but that is certainly safe.
>
> Can you clarify that comment a bit for me?    Why are they too wide, 
> and
> if they are too wide, how are they still safe?

A few vectors that can be used freely are marked as
not being so.  That is fine, there are plenty left.


Segher
