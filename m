Return-Path: <galak@kernel.crashing.org>
In-Reply-To: <20070820060000.GA26100@localhost.localdomain>
References: <Pine.LNX.4.64.0708181203320.31362@blarg.am.freescale.net>
	<20070820060000.GA26100@localhost.localdomain>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <A4E8D00C-87DB-4C59-A6C4-70D437ED9988@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH 0/3 v2] Remove need for include/asm-ppc
Date: Mon, 20 Aug 2007 10:32:43 -0500
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


On Aug 20, 2007, at 1:00 AM, David Gibson wrote:

> On Sat, Aug 18, 2007 at 12:05:36PM -0500, Kumar Gala wrote:
>> This patch series removes the need for include/asm-ppc in the  
>> ARCH=powerpc
>> build for ppc32.  They exist in the following git tree:
>>
>>   master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git  
>> for-2.6.24
>>
>> posting here for everyone else to see.
>>
>> Updated with changes suggested by Arnd & Segher. (removal 82xx pci  
>> header
>> and moving some headers under platforms if not globally needed).
>
> Nice!  I'm hoping the next step after this is to do the other way
> around - make ARCH=ppc builds independent of things in arch/powerpc or
> include/asm-powerpc, which is almost the more important change.

Maybe, hadn't thought about that case.  One thing at a time :)

Do we want to go and move stuff back out of arch/powerpc/kernel back  
into arch/ppc/kernel?  or just include files?

- k
