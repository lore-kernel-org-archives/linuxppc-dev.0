Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e36.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 0C372DDE1A
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 09:38:21 +1100 (EST)
Received: from d03relay02.boulder.ibm.com (d03relay02.boulder.ibm.com
	[9.17.195.227])
	by e36.co.us.ibm.com (8.13.1/8.13.1) with ESMTP id n2AMb2Ic029929
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:37:02 -0600
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
	by d03relay02.boulder.ibm.com (8.13.8/8.13.8/NCO v9.2) with ESMTP id
	n2AMcIw1204348
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:38:18 -0600
Received: from d03av03.boulder.ibm.com (loopback [127.0.0.1])
	by d03av03.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	n2AMcH1o012799
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Mar 2009 16:38:18 -0600
Date: Tue, 10 Mar 2009 18:37:53 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH v5] introduce macro spin_event_timeout()
Message-ID: <20090310223753.GB26415@zod.rchland.ibm.com>
References: <1236723118-3577-1-git-send-email-timur@freescale.com>
	<49B6EAA4.9000803@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <49B6EAA4.9000803@freescale.com>
Cc: linuxppc-dev@ozlabs.org, Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Mar 10, 2009 at 05:33:08PM -0500, Scott Wood wrote:
> Timur Tabi wrote:
>> The macro spin_event_timeout() takes a condition and timeout value
>> (in microseconds) as parameters.  It spins until either the condition is true
>> or the timeout expires.  It returns zero if the timeout expires first, non-zero
>> otherwise.
>>
>> This primary purpose of this macro is to poll on a hardware register until a
>> status bit changes.  The timeout ensures that the loop still terminates if the
>> bit doesn't change as expected.  This macro makes it easier for driver
>> developers to perform this kind of operation properly.
>>
>> Signed-off-by: Timur Tabi <timur@freescale.com>
>> ---
>>
>> v5: ported to arch/powerpc, made it powerpc-specific, eliminated udelay
>
> Why make it powerpc-specific?  This would be nice to have in  
> arch-independent code.

That's just mean.  He already posted it to lkml and was told to make it
powerpc specific by Alan.

josh
