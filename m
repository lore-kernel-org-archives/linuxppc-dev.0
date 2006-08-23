Return-Path: <tim.bird@am.sony.com>
Received: from mail43-fra-R.bigfish.com (mail-fra.bigfish.com [62.209.45.166])
	(using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
	(Client CN "*.bigfish.com", Issuer "*.bigfish.com" (not verified))
	by ozlabs.org (Postfix) with ESMTP id E812D67B70
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 02:33:15 +1000 (EST)
Message-ID: <44EC8338.3050203@am.sony.com>
Date: Wed, 23 Aug 2006 09:32:56 -0700
From: Tim Bird <tim.bird@am.sony.com>
MIME-Version: 1.0
To: Johannes Berg <johannes@sipsolutions.net>
Subject: Re: BogoMIPS no longer supported on PowerPC?
References: <1156329453.3914.13.camel@ux156>
In-Reply-To: <1156329453.3914.13.camel@ux156>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Johannes Berg wrote:
> On Wed, 2006-08-23 at 18:25 +0800, Li Yang-r58472 wrote:
>  > I noticed a recent modification to __delay has changed from using empty
>  > loops to reading timebase.  Thus, breaks the calculation of bogomips,
>  > and makes it terribly low.  Is the bogomips no longer being supported on
>  > powerpc arch?
> 
> What's there to be 'supported'? The only purpose of bogomips is
> calibrating the delay loop, and that has changed now by using timebase,
> hence bogomips no longer have a purpose. There was even a patch to
> remove it from /proc/cpuinfo but I'm not sure whether that got applied
> or not.

I missed the patch for this, but I have a related question.
What is the status of the calibration code now for PPC?
Is it just skipped?

I assume that the ability to set a preset loops_per_jiffy
is no longer relevant?
 -- Tim

=============================
Tim Bird
Architecture Group Chair, CE Linux Forum
Senior Staff Engineer, Sony Electronics
=============================
