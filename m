Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id E4EE5DE0C9
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 11:45:25 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2B0gmRE032638
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 18:42:48 -0600
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2B0jMfG196148
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 18:45:22 -0600
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2B0jLOS020048
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 18:45:22 -0600
Date: Tue, 10 Mar 2009 20:44:58 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
Message-ID: <20090311004458.GD26415@zod.rchland.ibm.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
	<20090310223753.GB26415@zod.rchland.ibm.com>
	<1236729551.7086.26.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1236729551.7086.26.camel@pasglop>
Cc: Scott Wood <scottwood@freescale.com>, linuxppc-dev@ozlabs.org,
	Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 11, 2009 at 10:59:11AM +1100, Benjamin Herrenschmidt wrote:
>On Tue, 2009-03-10 at 18:37 -0400, Josh Boyer wrote:
>> On Tue, Mar 10, 2009 at 05:33:08PM -0500, Scott Wood wrote:
>> > Timur Tabi wrote:
>> >> The macro spin_event_timeout() takes a condition and timeout value
>> >> (in microseconds) as parameters.  It spins until either the condition is true
>> >> or the timeout expires.  It returns zero if the timeout expires first, non-zero
>> >> otherwise.
>> >>
>> >> This primary purpose of this macro is to poll on a hardware register until a
>> >> status bit changes.  The timeout ensures that the loop still terminates if the
>> >> bit doesn't change as expected.  This macro makes it easier for driver
>> >> developers to perform this kind of operation properly.
>> >>
>> >> Signed-off-by: Timur Tabi <timur@freescale.com>
>> >> ---
>> >>
>> >> v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay
>> >
>> > Why make it powerpc-specific?  This would be nice to have in  
>> > arch-independent code.
>> 
>> That's just mean.  He already posted it to lkml and was told to make it
>> powerpc specific by Alan.
>
>And ? We can disagree with Alan...

Did I say Alan was right?  I'm just explaining why Timur probably posted it
as arch-specific.

josh
