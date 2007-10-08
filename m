Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 4EA8BDDEFC
	for <linuxppc-dev@ozlabs.org>; Tue,  9 Oct 2007 04:18:46 +1000 (EST)
In-Reply-To: <8B3EB438-F672-4E13-A29A-3F21D0048CF0@kernel.crashing.org>
References: <20071005174015.GA11016@localhost.localdomain>
	<20071005174642.GB32145@localhost.localdomain>
	<47067ADE.9060306@ru.mvista.com>
	<20071005180553.GA32405@localhost.localdomain>
	<EB9BE8E7-6437-403F-A7F4-953B393FDF51@kernel.crashing.org>
	<20071008120849.GA32540@localhost.localdomain>
	<8B3EB438-F672-4E13-A29A-3F21D0048CF0@kernel.crashing.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <56D6B279-8C0E-425A-A869-C4636272BFF8@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 6/7] [POWERPC] mpc8568mds.dts: fix PCI/PCIe nodes
Date: Mon, 8 Oct 2007 13:18:53 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

>>
>> Which patch? Valentine's or mine under the subject? Don't know
>> about the
>> former, but mine patch is pretty obvious: your commit
>> 5bece127f0666996ca90772229e00332a34e516c moved PCI nodes out of soc
>> node,
>> but you forgot to change regs = <>, thus instead of e000a000/ 
>> e0008000,
>> kernel used a000/8000 for accessing PCI ccsr registers.
>
> Yeah, I see that bug now.  It looks like I wasn't getting my new .dts
> on the board.  Will fixup that issue in my patch.

Ok, I've tested my updated tree and it works for PCIe with the fix to  
the .dts

- k
