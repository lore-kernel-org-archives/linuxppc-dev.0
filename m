Return-Path: <yhlu.kernel@gmail.com>
Received: from rv-out-0506.google.com (rv-out-0506.google.com [209.85.198.233])
	by ozlabs.org (Postfix) with ESMTP id 4F283DDE0F
	for <linuxppc-dev@ozlabs.org>; Sun,  9 Nov 2008 09:13:54 +1100 (EST)
Received: by rv-out-0506.google.com with SMTP id f6so1683156rvb.9
	for <linuxppc-dev@ozlabs.org>; Sat, 08 Nov 2008 14:13:53 -0800 (PST)
Message-ID: <86802c440811081413v58ffb2fah90849e7aa26cc67f@mail.gmail.com>
Date: Sat, 8 Nov 2008 14:13:53 -0800
From: "Yinghai Lu" <yinghai@kernel.org>
Sender: yhlu.kernel@gmail.com
To: "Andrew Morton" <akpm@linux-foundation.org>
Subject: Re: [PATCH 1/1] irq: Maintain user set affinity
In-Reply-To: <20081106133524.75588d96.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
References: <Pine.LNX.4.64.0811041030520.25054@blarg.am.freescale.net>
	<20081106133524.75588d96.akpm@linux-foundation.org>
Cc: linuxppc-dev@ozlabs.org, tglx@linutronix.de, torvalds@linux-foundation.org,
	linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Nov 6, 2008 at 1:35 PM, Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue, 4 Nov 2008 10:31:05 -0600 (CST)
> Kumar Gala <galak@kernel.crashing.org> wrote:
>
>> >From 819ad3ed4660f4238e053728a8b5aa93d22b13d7 Mon Sep 17 00:00:00 2001
>> From: Kumar Gala <galak@kernel.crashing.org>
>> Date: Tue, 4 Nov 2008 10:13:53 -0600
>> Subject: [PATCH 1/1] irq: Maintain user set affinity
>>
>> This addresses a regression in that if a user specified an affinity
>> for an interrupt that affinity information would get reset between
>> a request_irq(), free_irq() and request_irq() for the same irq.
>>
...
>
> Are you able to identify when this regression occurred?  It isn't
> immediately obvious to me.
>
> If the regression is present in 2.6.27 or earlier, do you think we
> should backport the fix?  If so, a different patch would be needed due
> to the presence of

it seems that is not a regression...

YH
