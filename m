Return-Path: <reynekejunk@hotmail.com>
Received: from bay0-omc3-s32.bay0.hotmail.com (bay0-omc3-s32.bay0.hotmail.com
	[65.54.246.232]) by ozlabs.org (Postfix) with ESMTP id 5922CDDDE5
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 22 Jan 2007 08:30:00 +1100 (EST)
Message-ID: <BAY7-F10867A8D2E772EBEFA6A8CBEAF0@phx.gbl>
In-Reply-To: <Pine.WNT.4.61.0701191344190.2536@holyoke.labs.mot.com>
From: "- Reyneke" <reynekejunk@hotmail.com>
To: ctz001@email.mot.com
Subject: Re: Howto use PPC4xx memory to memory DMA
Date: Sun, 21 Jan 2007 21:28:34 +0000
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Yes, I know - that email is in response to a question I posted.  :)

This seems to be one of those ongoing uncertainties. It seems commonly 
advocated that you shouldn't use it, but as yet I've found no suitable 
alternative.

Some more reading on why you *should* use it:

http://ozlabs.org/pipermail/linuxppc64-dev/2004-March/001276.html

It would be nice if we could get a definitive answer to this. Anyone out 
there who knows?

Cheers
   Jan Reyneke


>From: T Ziomek <ctz001@email.mot.com>
>>
>>source = virt_to_bus((u32 *)mem);
>
>The above contradicts an email by Ben H back on 22 Dec:
><http://ozlabs.org/pipermail/linuxppc-embedded/2006-December/025546.html>
>But I don't know enough to resolve the conflict...
>
>Tom

_________________________________________________________________
Get Hotmail, News, Sport and Entertainment from MSN on your mobile.  
http://www.msn.txt4content.com/
