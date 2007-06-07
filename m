Return-Path: <rvinson@mvista.com>
Received: from zipcode.az.mvista.com (unknown [65.200.49.156])
	by ozlabs.org (Postfix) with ESMTP id EFE77DDF0E
	for <linuxppc-dev@ozlabs.org>; Fri,  8 Jun 2007 04:04:55 +1000 (EST)
Message-ID: <466848C0.8020402@mvista.com>
Date: Thu, 07 Jun 2007 11:04:48 -0700
From: Randy Vinson <rvinson@mvista.com>
MIME-Version: 1.0
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [RFC] 85XX: Allow 8259 cascade to share an MPIC interrupt line.
References: <466755AC.40201@mvista.com> <1181230255.31686.3.camel@ld0161-tx32>
In-Reply-To: <1181230255.31686.3.camel@ld0161-tx32>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger wrote:
> On Wed, 2007-06-06 at 19:47, Randy Vinson wrote:
[snippage]

>> Signed-off-by: Randy Vinson <rvinson@mvista.com>
>> ---
>> Note that there may very well be a better way of accomplishing this. If someone
>> has a better alternative, I'm open to it. This was just the simplest way I could
>> get this to work.
>>
>> Also, the addition of the .end routine for the MPIC is not strictly necessary for
>> this patch. It's there so this code will run from within the threaded interrupt
>> context used by the Real Time patch.
> 
> 
> Hmm.  I feel that at least the last paragraph here needs
> to be above the --- line for future patch readers.  Otherwise
> it's relationship to the rest of the patch details will be
> intermixed and lost.
OK. That's a good idea. I'll update that for the next round.

Thx,
Randy V.
