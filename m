Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B6F1CDE00C
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jan 2008 08:46:22 +1100 (EST)
Message-ID: <4783EF30.6030604@freescale.com>
Date: Tue, 08 Jan 2008 15:46:24 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: Generic desktop/server/laptop lable is confusing [Was Re: [PATCH
	3/7] Basic Freescale MPC512x support]
References: <1199808093-15929-1-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-2-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-3-git-send-email-jrigby@freescale.com>	
	<1199808093-15929-4-git-send-email-jrigby@freescale.com>	
	<fa686aa40801080919y7c426007vd031bb79e8f9a03d@mail.gmail.com>	
	<20080108175513.GC5188@loki.buserror.net>	
	<fa686aa40801080956n20f31a54xe02328a139ac3a3b@mail.gmail.com>	
	<20080108192531.GB5296@loki.buserror.net>	
	<4783DF12.9050700@freescale.com>
	<fa686aa40801081340l1eed359arf345b020b4a410a0@mail.gmail.com>
In-Reply-To: <fa686aa40801081340l1eed359arf345b020b4a410a0@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Grant Likely wrote:
> On 1/8/08, John Rigby <jrigby@freescale.com> wrote:
>>> It may work, but it pulls in code like prom_init.c that is not needed on
>>> non-OF boards.  It's also quite confusing to have an embedded board's
>>> checkbox only show up when you say yes to "Generic desktop/server/laptop".
>>>
>> I have to agree with this, I have been confused by this myself.
>> Perhaps the prompt should be changed to something less
>> confusing?
> 
> I'm agreeable to that.  Maybe simply "Multiplatform" with a better
> description in the help text?

Why do we need a config option for "multiplatform" at all?  It seems to 
be currently used to hang a few random, non-embeddy things off of such 
as real OF and SMT.  Let's clean up the mess rather than change the 
description.

-Scott
