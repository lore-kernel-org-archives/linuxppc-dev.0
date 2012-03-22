Return-Path: <kyle@moffetthome.net>
Received: from mail-vx0-f170.google.com (mail-vx0-f170.google.com
 [209.85.220.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10226B6F98
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 15:13:49 +1100 (EST)
Received: by vcbfo14 with SMTP id fo14so1789927vcb.15
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 21:13:46 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <CA+55aFz-pyBHa73zkbkub4czwnU+k4_qKzBEaAGvi66MBBUTpQ@mail.gmail.com>
References: <1332377206.2982.60.camel@pasglop>
 <CA+55aFz-pyBHa73zkbkub4czwnU+k4_qKzBEaAGvi66MBBUTpQ@mail.gmail.com>
From: Kyle Moffett <kyle@moffetthome.net>
Date: Wed, 21 Mar 2012 21:13:24 -0700
Message-ID: <CAGZ=bqJU5nd71ei2OatsRRqr_hLdPQLiE1MXD7VEtb9n0v7yaw@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Linus Torvalds <torvalds@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Cc: Russell King <linux@arm.linux.org.uk>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2012 at 19:02, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
> On Wed, Mar 21, 2012 at 5:46 PM, Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:
>> Here's the powerpc batch for this merge window. It is going to be a bit
>> more nasty than usual as in touching things outside of arch/powerpc
>> mostly due to the big iSeriesectomy :-) We finally got rid of the bugger
>> (legacy iSeries support) which was a PITA to maintain and that nobody
>> really used anymore.
>>
>> Here are some of the highlights:
>
> Ok, so this conflicted a bit with the generalized irq-domain stuff
> from Grant Likely, and while I tried to fix it up I can't even
> compile-test the end result, so you really need to verify my merge and
> perhaps send me fixups. Ok?
>
> Especially the sysdev/mpic.c resolution needs somebody who knows the
> code to verify. Added Grant and Kyle explicitly to the cc..

As I'm no longer at Boeing, my old @boeing.com address probably
bounces.  Please feel free to send stuff to my personal address:
kyle@moffetthome.net

I don't know that I'll be much help, but I will try to look over the
resolved mpic code this evening to see if anything jumps out at me.

Cheers,
Kyle Moffett
