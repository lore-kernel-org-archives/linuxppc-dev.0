Return-Path: <jonsmirl@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.234])
	by ozlabs.org (Postfix) with ESMTP id 8EA9FDE0EE
	for <linuxppc-dev@ozlabs.org>; Tue, 27 Jan 2009 15:26:58 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so6341957rvb.9
	for <linuxppc-dev@ozlabs.org>; Mon, 26 Jan 2009 20:26:57 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <497E81DD.9020408@trimble.com>
References: <497E81DD.9020408@trimble.com>
Date: Mon, 26 Jan 2009 23:26:56 -0500
Message-ID: <9e4733910901262026i76ed36c5ue6b2e689779c6689@mail.gmail.com>
Subject: Re: any luck with wireless USB adaptors?
From: Jon Smirl <jonsmirl@gmail.com>
To: mike_timmons@trimble.com
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, Jan 26, 2009 at 10:39 PM, Mike Timmons <mike_timmons@trimble.com> wrote:
> I'm running 2.6.24 with Freescale's lite5200 as my base. I'm interested in
> this USB adaptor for wireless USB, but my web search does not make me
> confident that my effort will yield fruit.

I just turned on all wireless drivers in my mpc5200 build and they all
built ok. I'm using Linus' current git tree.
rt2501 (WUSB54GC) is in the current kernel.

AFAIK these should work. Some times there are minor problems with
endianess but they aren't hard to fix. The usual error is loading the
firmware byte swapped.

>
> Can anyone direct me to a good source outlining success stories with
> wireless USB adaptors? At present I'm mesing with Linksys WUSB54GC and some
> driver source from Ralink, but my cross-compile is not working.
>
> I'll keep wrestling with it, but please offer some advice if you can.
>
> Thanks!
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
>



-- 
Jon Smirl
jonsmirl@gmail.com
