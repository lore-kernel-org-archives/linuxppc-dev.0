Return-Path: <juergen127@kreuzholzen.de>
Received: from bill.weihenstephan.org (bill.weihenstephan.org [82.135.35.21])
	by ozlabs.org (Postfix) with ESMTP id 3BBCBDDEF0
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 23:11:19 +1000 (EST)
From: Juergen Beisert <juergen127@kreuzholzen.de>
To: linuxppc-embedded@ozlabs.org
Subject: Re: [Trace how to] Kernel Bug when entering something after login
Date: Thu, 26 Jul 2007 14:45:29 +0200
References: <200707251900.47704.juergen127@kreuzholzen.de>
	<200707261000.25465.juergen127@kreuzholzen.de>
	<f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
In-Reply-To: <f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200707261445.30391.juergen127@kreuzholzen.de>
Cc: linux-rt-users@vger.kernel.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Thursday 26 July 2007 14:34, Pradyumna Sampath wrote:
> Hi Everyone,
>
> On 7/26/07, Juergen Beisert <juergen127@kreuzholzen.de> wrote:
> > On Wednesday 25 July 2007 21:06, Thomas Gleixner wrote:
> > > Solution below
> >
> > Seems to work now. Thanks.
> >
> > Juergen
> > -
>
> First of all very sorry to cross post.
>
> I discovered the same problem on our MPC5200 and it after patching, it
> now works. But I could somehow not get the call trace and hence could
> not report the bug.
>
> I compiled the kernel with "CONFIG_FUNCTION_TRACE" and then I get
> undefined references on "early_printk". Is there something I am doing
> wrong in the kernel config or was there an additional patch to enable
> this support for MPC5200 ?
>
> I see more bugs when I run "stress" but I cant solve them or even
> report them, because I cant see the trace information.

Activate "General setup" -> "Configure standard kernel features (for small 
systems)" -> "Load all symbols for debugging/ksymoops"

Juergen
