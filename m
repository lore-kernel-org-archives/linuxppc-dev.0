Return-Path: <rpjday@mindspring.com>
Received: from mailhost.rdmcorp.com (world.rdmcorp.com [204.225.180.10])
	by ozlabs.org (Postfix) with ESMTP id 732D02BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  8 Oct 2004 02:24:18 +1000 (EST)
Date: Thu, 7 Oct 2004 12:17:29 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Tom Rini <trini@kernel.crashing.org>
In-Reply-To: <20041007154557.GF14773@smtp.west.cox.net>
Message-ID: <Pine.LNX.4.60.0410071215510.5288@dell.enoriver.com>
References: <Pine.LNX.4.60.0410060908520.8324@dell.enoriver.com>
	<20041007154557.GF14773@smtp.west.cox.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: Re: [PATCH] 2.6.9(?) kernel, replacing ucode patch infrastructure
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thu, 7 Oct 2004, Tom Rini wrote:

> On Wed, Oct 06, 2004 at 09:15:56AM -0400, Robert P. J. Day wrote:
>
>>
>>   ok, one more time, here's a patch that should apply cleanly to the
>> latest bk repo for linuxppc-2.5.  the purpose is to create a cleaner
>> and more extensible microcode patch infrastructure, so that all you
>> need to do is *select* the 8xx-relevant patch you want from the config
>> menu under "MPC8xx" options.
>
> This doesn't apply cleanly, even if I tell patch to ignore whitespace
> changes.  Please re-generate, thanks.

sorry, i sent the last reply just to tom.  the much larger patch 
referred to here should be applied *instead* of the earlier tinier 
patch, since i thought we had established that i should send larger, 
self-contained patches, and that we'd ignore all of my earlier 
submissions.

the obvious solution is to unapply that earlier, tiny patch -- then 
this one should go in smoothly.

rday
