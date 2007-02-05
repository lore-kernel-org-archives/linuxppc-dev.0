Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id EF5F1DDE2C
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  6 Feb 2007 03:20:46 +1100 (EST)
In-Reply-To: <000601c74754$b9a1eb90$6405a8c0@absolut>
References: <000c01c746db$6451e7e0$6405a8c0@absolut>
	<06A02CF1-7D0C-4D59-9628-A2EB0FF3CCF4@kernel.crashing.org>
	<001101c746e3$5b8dab00$6405a8c0@absolut>
	<A755B15B-9C78-40E1-998D-FE9E68E74805@kernel.crashing.org>
	<000601c74754$b9a1eb90$6405a8c0@absolut>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <4A62CA3B-408B-4F63-BDF4-671B6EB88F67@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: MPC8360 : PCI resource allocate error
Date: Mon, 5 Feb 2007 10:19:49 -0600
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


On Feb 2, 2007, at 11:32 PM, Russell McGuire wrote:

> Comments in line:
>
>> On Feb 2, 2007, at 10:01 AM, Russell McGuire wrote:
>>
>>> Here is the current .dts mapping, though I am beginning to  
>>> suspect the
>>> hardware or a possible U-boot bug on this.
>>>
>>> U-boot can't see the PCI USB card in SLOT 3, but it can see the all
>>> of the
>>> other various PCI cards I have <ATI video card, sound card, ATA  
>>> card,
>>> network card>
>>
>> Are any cards detected in SLOT 3 with u-boot?  If not, I'd think HW
>> as well.
>
> Yes, actually of the 6 cards I have, all are seen except the USB card.
> And the USB card is seen in all other slots. So it appears to be a  
> SLOT
> issue, but not a card issue.  Somehow this card is unique and  
> uncovering an
> error that I don't know about yet. Perhaps I have a single address  
> line
> sizzled or something. This is the same slot that has the IO resource
> allocation problems; I don't think I need to debug that in Linux.
>
> OR..
>
> Is there any PCI test code out there??? Maybe I should forego the  
> drivers,
> and figure out some kind of test. I made a blind assumption in U- 
> boot that
> if it worked to detect cards that everything was in order.

The only thing that u-boot seeing a card tests is that PCI config  
cycles are working.  It doesn't cover anything like bus mastering, or  
interrupts, etc.  (and there is still a possibility of address/data  
line problems).

- k
