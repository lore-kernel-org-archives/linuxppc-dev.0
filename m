Return-Path: <chris.friesen@genband.com>
Received: from exprod7og118.obsmtp.com (exprod7og118.obsmtp.com [64.18.2.8])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1FC151007D8
	for <linuxppc-dev@ozlabs.org>; Fri, 17 Sep 2010 07:48:30 +1000 (EST)
Message-ID: <4C928FC5.9050700@genband.com>
Date: Thu, 16 Sep 2010 15:44:37 -0600
From: Chris Friesen <chris.friesen@genband.com>
MIME-Version: 1.0
To: Scott Wood <scottwood@freescale.com>
Subject: Re: linux support for freescale e5500 core?
References: <4C9278CD.10607@genband.com>
	<20100916163911.6255d359@schlenkerla.am.freescale.net>
In-Reply-To: <20100916163911.6255d359@schlenkerla.am.freescale.net>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org, timur@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2010 03:39 PM, Scott Wood wrote:
> On Thu, 16 Sep 2010 14:06:37 -0600
> Chris Friesen <chris.friesen@genband.com> wrote:
> 
>> We're looking at maybe doing some work with an e5500-based system.  Is
>> there any support existing/planned for this core?
> 
> Check with whoever you'd be getting the hardware from about a BSP.
> 
> And yes, it should be supported upstream at some point.

We haven't settled on a vendor yet, so I was just wondering in general
what the story was around support.

>> Also, do we know what the cache line size is--we have some legacy apps
>> that assume 32-byte.
> 
> The cache line is 64 bytes.  As with e500mc, there is a "dcbz32" mode
> for compatibility, though you probably lose much of the performance
> benefit of dcbz, and it might upset other software that properly checks
> for the cache line size but doesn't use dcbzl.

Right.  We currently use a 970-series cpu and have implemented a
per-process flag to indicate whether 32-byte mode is needed or not.
We'd have to do something similar with the new cpu.

One last question--can you comment on the speed of an e5500 relative to
a 970 for integer operations?

Thanks,

Chris


-- 
Chris Friesen
Software Developer
GENBAND
chris.friesen@genband.com
www.genband.com
