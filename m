Return-Path: <mohanreddykv@gmail.com>
Received: from mail-fx0-f51.google.com (mail-fx0-f51.google.com
	[209.85.161.51]) (using TLSv1 with cipher RC4-SHA (128/128 bits))
	(Client CN "smtp.gmail.com",
	Issuer "Google Internet Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DD1ADB6F7E
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 22 Sep 2011 16:22:39 +1000 (EST)
Received: by fxe22 with SMTP id 22so2579449fxe.38
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 21 Sep 2011 23:22:34 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4E7A3DED.9030402@freescale.com>
References: <CAFbQSaD-c=QqSsq__VtBEcMCJabnBi4AP4KunDNV7u7xXAuaTw@mail.gmail.com>
	<4E73816C.6000304@freescale.com>
	<CAFbQSaBcdLCoVY471mVLAyM=eYDSN77=DODPasMaAEm6pRm7jQ@mail.gmail.com>
	<4E7A3DED.9030402@freescale.com>
Date: Thu, 22 Sep 2011 11:52:34 +0530
Message-ID: <CAEZ9+qnSXXi5w9BbwyaQWQybCtaCsJ0T5j5ySEjOkpnnYmr7aA@mail.gmail.com>
Subject: Re: Timer interrupt on Linux 3.0.3
From: MohanReddy koppula <mohanreddykv@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@lists.ozlabs.org, linux-embedded@vger.kernel.org,
	Vineeth <vneethv@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

I had the same issue with an MPC885 board. My kernel was 2.6.33. On
that board decrementer exception was not working. I replaced the
board, took new board (MPC885 only, just another board) and the same
kernel worked fine. I don't know how the problem was solved.

-Mohan

On 9/22/11, Scott Wood <scottwood@freescale.com> wrote:
> On 09/21/2011 01:56 AM, Vineeth wrote:
>>>> What was the issue?  You really should try to make this work rather than
>>>> hack around it.
>>
>> what we found was the decrementer is not generating an exception when it
>> becomes 0. and the timebase registers are not getting incremented too.
>
> Does the decrementer actually tick until it reaches zero, or do it and
> the timebase never tick?
>
> Is the TBEN input to the CPU asserted?
>
> -Scott
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
