Return-Path: <mmporter@cox.net>
Received: from fed1rmmtao06.cox.net (fed1rmmtao06.cox.net [68.230.241.33])
	by ozlabs.org (Postfix) with ESMTP id BE4AB2BC0F
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 28 Sep 2004 23:50:29 +1000 (EST)
Date: Tue, 28 Sep 2004 06:50:26 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Marc Leeman <marc.leeman@gmail.com>
Message-ID: <20040928065026.B31883@home.com>
References: <1f729c4804092806332aaf052e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1f729c4804092806332aaf052e@mail.gmail.com>;
	from marc.leeman@gmail.com on Tue, Sep 28, 2004 at 03:33:16PM
	+0200
Cc: Linux PowerPC Embedded Mailinglist <linuxppc-embedded@ozlabs.org>
Subject: Re: throughput question
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Tue, Sep 28, 2004 at 03:33:16PM +0200, Marc Leeman wrote:
> I see some mails passing over the list about gigabit interfaces, so I
> wonder if there are any suggestions as to what processor/interface
> should be used for high througput.
> 
> I am currently working on a 8245 based board with 2.4.27 e100 driver
> and when taking in (and processing streams), only about 50 Mbps can be
> handled: about half of the time is based in kernel space (handling
> interrupts).
> 
> The eepro100 driver was much worse.
> 
> As a result, I am a bit wondering about the higher bitrates. How much
> do you achieve on tests with what hardware?

What benchmark do you use to measure throughput? Since you are
processing streams sounds like you have an application-based
benchmark rather than one of the typical ones. You can probably
show the good throughput if you pick another benchmark, but it
probably won't answer your system design question.

-Matt
