Return-Path: <pradyumna.sampath@gmail.com>
Received: from py-out-1112.google.com (py-out-1112.google.com [64.233.166.177])
	by ozlabs.org (Postfix) with ESMTP id 675EFDDEE1
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 22:34:23 +1000 (EST)
Received: by py-out-1112.google.com with SMTP id a29so1223959pyi
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 26 Jul 2007 05:34:21 -0700 (PDT)
Message-ID: <f87351060707260534k2f87ff47rdcfd0b787d5a0132@mail.gmail.com>
Date: Thu, 26 Jul 2007 18:04:21 +0530
From: "Pradyumna Sampath" <pradyumna.sampath@gmail.com>
To: "Juergen Beisert" <juergen127@kreuzholzen.de>
Subject: [Trace how to] Kernel Bug when entering something after login
In-Reply-To: <200707261000.25465.juergen127@kreuzholzen.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
References: <200707251900.47704.juergen127@kreuzholzen.de>
	<1185390398.3227.8.camel@chaos>
	<200707261000.25465.juergen127@kreuzholzen.de>
Cc: linux-rt-users@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Everyone,

On 7/26/07, Juergen Beisert <juergen127@kreuzholzen.de> wrote:
> On Wednesday 25 July 2007 21:06, Thomas Gleixner wrote:
> > Solution below
>
> Seems to work now. Thanks.
>
> Juergen
> -

First of all very sorry to cross post.

I discovered the same problem on our MPC5200 and it after patching, it
now works. But I could somehow not get the call trace and hence could
not report the bug.

I compiled the kernel with "CONFIG_FUNCTION_TRACE" and then I get
undefined references on "early_printk". Is there something I am doing
wrong in the kernel config or was there an additional patch to enable
this support for MPC5200 ?

I see more bugs when I run "stress" but I cant solve them or even
report them, because I cant see the trace information.

thanks in advance
regards
/prady

-- 
htp://prady.livejournal.com
