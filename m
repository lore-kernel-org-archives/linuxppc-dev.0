Return-Path: <david.jander@protonic.nl>
Received: from protonic.prtnl (protonic.xs4all.nl [213.84.116.84])
	by ozlabs.org (Postfix) with ESMTP id 9443D688D9
	for <linuxppc-embedded@ozlabs.org>;
	Mon, 19 Dec 2005 20:40:08 +1100 (EST)
From: David Jander <david.jander@protonic.nl>
To: linuxppc-embedded@ozlabs.org
Date: Mon, 19 Dec 2005 10:39:56 +0100
References: <821B2170E9E7F04FA38DF7EC21DE4871022BB9A9@VCAEXCH01.hq.corp.viasat.com>
In-Reply-To: <821B2170E9E7F04FA38DF7EC21DE4871022BB9A9@VCAEXCH01.hq.corp.viasat.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200512191039.58149.david.jander@protonic.nl>
Cc: "Martin, Tim" <tim.martin@viasat.com>
Subject: Re: POSIX High Resolution Timers in LinuxPPC 2.4
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Hi Tim,

On Friday 16 December 2005 23:34, Martin, Tim wrote:
> Could someone give me a brief history lesson on POSIX high resolution
> timers (e.g. timer_create() function) implemented in the Linux kernel on
> the PowerPC 405 architecture?  Specifically:
>
> Confirm they are in the mainline 2.6 kernel now (e.g. kernel.org)?
>
> Were they ever a part of the "mainline" 2.4 linuxppc kernel (e.g
> ppc.bkbits.net)?
>
> If no, were they ever available as a patch? The stuff at
> sourceforge.net/projects/high-res-timers stops at 2.4.20 and looks like it
> was only ever working for i386, not ppc.

I asked a related question a while back, and got no answer (yet).
I did find this though, which you might have overlooked:
http://prdownloads.sourceforge.net/high-res-timers/ppc-hrt-2.6.10.patch?download

I am equally puzzled about whether this has made it into mainstream, is about 
to, or never will. I don't even know if it actually works.

Greetings,

-- 
David Jander
Protonic Holland.
