Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4F490DDDFC
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  4 Oct 2007 08:48:34 +1000 (EST)
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B037591FD@ismail.innsys.innovsys.com>
References: <20071003190140.GA19169@xyzzy.farnsworth.org>
	<DCEAAC0833DD314AB0B58112AD99B93B0371EFE9@ismail.innsys.innovsys.com>
	<0B763FCF-9EFD-48E5-B2D9-53EAB0396522@kernel.crashing.org>
	<DCEAAC0833DD314AB0B58112AD99B93B037591FD@ismail.innsys.innovsys.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <20D3652D-CBD1-439D-BD4A-6D650F65BAEE@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] PPC 85xx failure with odd memory sizes and CONFIG_HIGHMEM
Date: Wed, 3 Oct 2007 17:48:18 -0500
To: "Rune Torgersen" <runet@innovsys.com>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


On Oct 3, 2007, at 4:45 PM, Rune Torgersen wrote:

>> From: Kumar Gala
>> The code would have to change to allow for 1G of lowmem.
>> Max lowmem with KERNELBASE @ 0xc000_0000 is 768M.
>
> Which is why I asked. On 82xx it is supported without a codechange by
> setting KERNELBASE to 0xa000_0000 in Kconfig menu (and also changing
> start of virtual mem, also done by config option).

we could make this work.  Its just no one's griped about needing it  
to date.

Its a bit of testing to make sure we respect the kernel config  
changes and a slight be of code to handle using up to 1G TLB sizes on  
e500v2 or greater.

- k
