Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070718032857.GF18251@localhost.localdomain>
References: <20070718013137.GA15217@ld0162-tx32.am.freescale.net>
	<20070718013611.GY15238@ld0162-tx32.am.freescale.net>
	<20070718032857.GF18251@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <F5E8139F-E8DA-4C41-8B90-E727FD4E346C@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 53/61] 82xx: Set NOT_COHERENT_CACHE on 8272 with PCI.
Date: Tue, 17 Jul 2007 23:30:32 -0500
To: David Gibson <david@gibson.dropbear.id.au>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jul 17, 2007, at 10:28 PM, David Gibson wrote:

> On Tue, Jul 17, 2007 at 08:36:11PM -0500, Scott Wood wrote:
>> I've seen significant network corruption on a PCI network
>> card (e1000) with the mpc8272ads; the corruption went away
>> when I set CONFIG_NOT_COHERENT_CACHE.
>>
>> Signed-off-by: Scott Wood <scottwood@freescale.com>
>
> Hrm... I for one would be a lot more comfortable with this patch if
> you had a theoretical explanation for why it's necessary, in addition
> to the "seems to fix things".

I agree w/David.  Have you tried turning on the  
CPU_FTR_NEED_COHERENT?  Take a look at include/asm-powerpc/cputable.h  
and search for the reference to CONFIG_PPC_83xx.

Even if that solves the problem we need to figure out of there is an  
errata or what that causes this to work.

- k
