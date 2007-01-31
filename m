Return-Path: <MGalassi@c-cor.com>
Received: from ns1.c-cor.com (ns1.c-cor.com [12.17.0.130])
	by ozlabs.org (Postfix) with ESMTP id 7C4F3DDE07
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 31 Jan 2007 14:34:12 +1100 (EST)
Message-Id: <200701310333.l0V3XwBe009802@penguin.ncube.com>
To: Dan Malek <dan@embeddedalley.com>
From: Michael Galassi <mgalassi@c-cor.com>
Subject: Re: mmap bug (all archs) w/ fix 
In-reply-to: Your message of "Tue, 30 Jan 2007 19:02:32 PST."
	<9163DAF8-7756-44DA-B6FF-5B9EC1605B00@embeddedalley.com>
Date: Tue, 30 Jan 2007 19:33:58 -0800
Sender: mgalassi@c-cor.com
Cc: ppc embedded list <linuxppc-embedded@ozlabs.org>
Reply-To: Michael Galassi <mgalassi@c-cor.com>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

>MTD does this very nicely for you, and you don't have
>to write any special programs......  :-)

MTD does have the ability to do this.  One might argue about the
philosophical merits of doing in kernel space (hard to debug) what can
trivially be done in user space (trivial to debug).  One might also
argue that the mtd code (I've perused it in some detail) takes a rather
cavalier approach to error checking and is thus not optimal for use in
real systems where reliability, dependability, and availability matter.

While our heroic "one" is busy arguing, I'll take a moment and point out
that the Linux kernel harbors a bug, the fix is trivial.  As long as the
argument still rages, I'll point out that advice from the "don't fix the
bug, work around it" crowd doesn't carry that much weight with the
paranoid amongst us.

>It's also much safer.

Under what circumstance is buggy kernel code safer than buggy user code?

-michael
