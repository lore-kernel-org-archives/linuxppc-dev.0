Return-Path: <armin.schindler@sysgo.com>
Received: from mail.sysgo.com (mail.sysgo.com [62.8.134.5])
	by ozlabs.org (Postfix) with ESMTP id 069C667A71
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Feb 2005 08:37:20 +1100 (EST)
Date: Mon, 21 Feb 2005 22:12:23 +0100 (CET)
From: Armin Schindler <armin.schindler@sysgo.com>
Sender: acs@sysgo.com
To: Dan Malek <dan@embeddededge.com>
In-Reply-To: <c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
Message-ID: <Pine.LNX.4.61.0502212206420.14199@acs.sysgo.com>
References: <EA78B62757AF1E4799828249310AC4CA071D281F@stca206a.bus.sc.rolm.com>
	<28F2CE72-0BF0-11D9-97DC-003065F9B7DC@embeddededge.com>
	<20050210150437.GA19134@logos.cnet>
	<c5f8c158f9254cbb0a8e085cf0fda8de@embeddededge.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linux-ppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: Re: Linux 2.6.x on 8xx status
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Dan,

On Thu, 10 Feb 2005, Dan Malek wrote:
>
> On Feb 10, 2005, at 10:04 AM, Marcelo Tosatti wrote:
>
>> Does anyone have a clue of what is/can be wrong with the TLB entry for the
>> address being flushed at __flush_dcache_icache()?
>
> Not sure.  The problem is that the __flush_dcache_icache is passed a
> user space virtual address that doesn't look like it is mapped for writing
> or something.  I don't know, as an ooops isn't sufficient to debug the 
> problem.
> You have to catch it here and track down the current state of the TLB and
> the page tables.  Of course, when I do this everything looks OK, so what
> I've been trying to do is catch the TLBmiss reload that actually causes this
> to happen to see what it really tried to load into the tlb.  A much more
> challenging project :-)  I'll get it one of these days .....

any news on that issue?

I just started with an MPC855/859 and run into the same problem with 
2.6.9.

Is there anything I can do or test?
Right now I'm not sure where to begin.

Even BDI-debugging would be possible...

Thanks,
Armin

---
Armin Schindler 
SYSGO AG
Am Pfaffenstein 14
D-55270 Klein-Winternheim / Germany
Phone: +49 6136 9948-0
Fax  : +49 6136 9948-10
armin.schindler@sysgo.com
www.sysgo.com
www.elinos.com
