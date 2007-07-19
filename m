Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <469E7350.3090308@freescale.com>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013611.GY15238@ld0162-tx32.am.freescale.net>
	<20070718032857.GF18251@localhost.localdomain>
	<F5E8139F-E8DA-4C41-8B90-E727FD4E346C@kernel.crashing.org>
	<469E7350.3090308@freescale.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <97B4A805-6E2A-4F8E-BC56-5BDEE8D6F5F0@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
Date: Thu, 19 Jul 2007 09:58:01 -0500
To: Scott Wood <scottwood@freescale.com>
Cc: linuxppc-dev@ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 18, 2007, at 3:08 PM, Scott Wood wrote:

> Kumar Gala wrote:
>> On Jul 17, 2007, at 10:28 PM, David Gibson wrote:
>>> Hrm... I for one would be a lot more comfortable with this patch if
>>> you had a theoretical explanation for why it's necessary, in  
>>> addition
>>> to the "seems to fix things".
>
> Sure, so would I; I just wanted to point out the issue, and make  
> available a quick fix for anyone else that might be having problems.
>
> My theoretical explanation is that the hardware is broken. :-P
>
>> I agree w/David.  Have you tried turning on the   
>> CPU_FTR_NEED_COHERENT?  Take a look at include/asm-powerpc/ 
>> cputable.h  and search for the reference to CONFIG_PPC_83xx.
>
> OK, that appears to work as well.

Can you dump the POCMRx registers and report their values and what / 
proc/iomem looks like.

- k
