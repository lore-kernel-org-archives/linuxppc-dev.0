Return-Path: <segher@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id E033C1007D1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Dec 2011 01:11:07 +1100 (EST)
In-Reply-To: <AE90C24D6B3A694183C094C60CF0A2F6D8AF0A@saturn3.aculab.com>
References: <AE90C24D6B3A694183C094C60CF0A2F6D8AF0A@saturn3.aculab.com>
Mime-Version: 1.0 (Apple Message framework v753.1)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <13A89594-34DE-40C7-8B13-D146C2F7F927@kernel.crashing.org>
From: Segher Boessenkool <segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: POWER7 optimised copy_to_user/copy_from_user
 using VMX
Date: Thu, 8 Dec 2011 15:12:26 +0100
To: "David Laight" <David.Laight@ACULAB.COM>
Cc: paulus@samba.org, Michael Neuling <mikey@neuling.org>,
 sukadev@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

>>> One idea would be to have a structure of function pointers for each
>>> CPU that gets runtime patched into the right places,
>>> similar to how we do some of the MMU fixups.
>>
>> Sounds good to me :-)
>
> Except the indirect jump/call is almost certainly
> never predicted - so will be slow.

What indirect jump?  He said "runtime patched" :-)

Also, that "slow" is largely a myth.


Segher
