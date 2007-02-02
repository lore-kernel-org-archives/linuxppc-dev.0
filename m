Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A6315DDEE9
	for <linuxppc-embedded@ozlabs.org>;
	Sat,  3 Feb 2007 03:08:20 +1100 (EST)
In-Reply-To: <001101c746e3$5b8dab00$6405a8c0@absolut>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
	<001101c746e3$5b8dab00$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8360 : PCI resource allocate error
Date: Fri, 2 Feb 2007 10:07:21 -0600
To: <rmcguire@videopresence.com>
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


On Feb 2, 2007, at 10:01 AM, Russell McGuire wrote:

> Here is the current .dts mapping, though I am beginning to suspect the
> hardware or a possible U-boot bug on this.
>
> U-boot can't see the PCI USB card in SLOT 3, but it can see the all  
> of the
> other various PCI cards I have <ATI video card, sound card, ATA card,
> network card>

Are any cards detected in SLOT 3 with u-boot?  If not, I'd think HW  
as well.

> All the cards that are seen by U-boot have the IO resource problem.  
> Only
> when in Slot 3.
>
> I probably need to direct this at the U-boot crowd, but what about  
> these
> defines in U-boot? Would they have any bearing? I forgot to publish  
> these
> when I originally had asked the question bout PCI IO space, but  
> they are the
> only ALL zero's in the mapping.

They shouldn't on just seeing the device.  Since PCI config cycles  
are used and U-boot will scan all busses you should at least see the  
device.

- k
