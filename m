Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 8169DB71C5
 for <linuxppc-dev@ozlabs.org>; Fri, 14 Oct 2011 02:50:39 +1100 (EST)
Subject: Re: [PATCH][v2] uio: Support 36-bit physical addresses on 32-bit
 systems
Mime-Version: 1.0 (Apple Message framework v1251.1)
Content-Type: text/plain; charset=us-ascii
From: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AE7E@saturn3.aculab.com>
Date: Thu, 13 Oct 2011 10:50:17 -0500
Message-Id: <9FAA2091-2FED-4B44-9224-6C735CF51D2C@kernel.crashing.org>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AE7E@saturn3.aculab.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: gregkh@suse.de, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
 hjk@hansjkoch.de, Jiang Kai-B18973 <B18973@freescale.com>,
 Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Oct 13, 2011, at 10:37 AM, David Laight wrote:

> 
>> Kumar Gala wrote:
>>>>>>> +       phys_addr_t             addr;
>>>>> 
>>>>> Please add a comment here saying:
>>>>> 
>>>>> 1) That 'addr' can be a virtual or physical address
>>> The code and everything else makes that clear
>> 
>> I'm sorry, but I have to strongly disagree here.  It is *NOT* 
>> clear that a variable of type 'phys_addr_t' can hold something
>> that is not a physical address.
> 
> Since there is a discriminating field, could a union be used?
> At a guess the type of the address is constrained between
> produces and consumer??

Uugh.

I'll add a comment to uio_mem.

- k
