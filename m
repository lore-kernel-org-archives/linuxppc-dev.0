Return-Path: <Tom.Ziomek@motorola.com>
Received: from mail119.messagelabs.com (mail119.messagelabs.com
	[216.82.241.179]) by ozlabs.org (Postfix) with SMTP id C168CDDE23
	for <linuxppc-dev@ozlabs.org>; Sat,  1 Dec 2007 09:30:57 +1100 (EST)
Received: from az33exr02.mot.com (az33exr02.mot.com [10.64.251.232])
	by motgate3.mot.com (8.12.11/Motorola) with ESMTP id lAUMUsTD021311
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 15:30:54 -0700 (MST)
Received: from az10vts01 (az10vts01.mot.com [10.64.251.242])
	by az33exr02.mot.com (8.13.1/Vontu) with SMTP id lAUMUrjt002861
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:30:53 -0600 (CST)
Received: from de01exm60.ds.mot.com (de01exm60.am.mot.com [10.176.8.105])
	by az33exr02.mot.com (8.13.1/8.13.0) with ESMTP id lAUMUqXv002843
	for <linuxppc-dev@ozlabs.org>; Fri, 30 Nov 2007 16:30:52 -0600 (CST)
Date: Fri, 30 Nov 2007 16:30:51 -0600 (CST)
From: T Ziomek <ctz001@email.mot.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 15/24] powerpc: early debug forces console log level to max
In-Reply-To: <1196460928.13230.111.camel@pasglop>
Message-ID: <Pine.LNX.4.64.0711301626000.5450@gauley.ddna.labs.mot.com>
References: <20071130061200.4BAF9DDFAE@ozlabs.org>
	<Pine.LNX.4.64.0711301306520.5450@gauley.ddna.labs.mot.com>
	<1196456185.13230.100.camel@pasglop>
	<Pine.LNX.4.64.0711301605540.5450@gauley.ddna.labs.mot.com>
	<1196460928.13230.111.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Cc: linuxppc-dev@ozlabs.org, T Ziomek <Tom.Ziomek@motorola.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sat, 1 Dec 2007, Benjamin Herrenschmidt wrote:
>
> On Fri, 2007-11-30 at 16:11 -0600, T Ziomek wrote:
>>> Possibly, though you aren't supposed to leave EARLY_DEBUG enabled
>>> once you are done debugging :-)
>>
>> I'm probably not the only person that would turn it on when needed,
>> think
>> "well, no harm in leaving it on for the rest of my development, and it
>> might be handy; just turn it off when we're done".
>>
>> It's these kind of non-obvious but undocumented things that make a lot
>> of
>> OSS code a pain to work with for non-experts [1].  What's the harm in
>> giving folks a heads-up?
>
> There is no harm, I didn't say I wasn't going to document it, you do
> have a point there, I was just mentioning by the way, that leaving
> EARLY_DEBUG is generally not a good idea in production.
>
> One of the things that arhc/powerpc provides is the ability for you to
> have a single kernel image boot boards with different 4xx processors for
> example, or different fsl booke processors. You lose that if you leave
> early debug on as it usually contain hard coded addresses for a given
> board.
>
> This is typically useful if you have several revisions / versions of
> your product, which could use different processor revisions or even
> model, and want a single kernel image to support them.

Makes sense (my last PPC work was with arch/ppc, when arch/powerpc was
just getting started, and I'm not using PPCs at the moment).

Maybe the better comment to add for EARLY_DEBUG is to turn it off when
not of immediate concern?

-- 
   /"\  ASCII Ribbon Campaign   |
   \ /                          |   Email to user 'CTZ001'
    X        Against HTML       |             at 'email.mot.com'
   / \     in e-mail & news     |
