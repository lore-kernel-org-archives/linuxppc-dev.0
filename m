Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id BFE2867A40
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Apr 2006 07:12:22 +1000 (EST)
To: Gautam Borad <gautam@eisodus.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Kernel panic on mpc852. 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 25 Apr 2006 19:27:14 +0530."
	<444E2ABA.60400@eisodus.com>
Date: Tue, 25 Apr 2006 23:12:21 +0200
Sender: wd@denx.de
Message-Id: <20060425211221.211B7353DAC@atlas.denx.de>
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

In message <444E2ABA.60400@eisodus.com> you wrote:
>
> I'm trying to port linux-2.4.21 to mpc852t custom board.
> The bootloader (u-boot) works fine and the kernel boots.
> The kernel is _VERY_ unstable, in that it gives sig 11
> ( Oops: kernel access of bad area, sig: 11 ) at random
> intervals.

2.4.21 is *very* old. I recommend to use a more  recent  (and  better
supported) version of the kernel.

And please read the FAQ, especially
http://www.denx.de/wiki/view/DULG/LinuxCrashesRandomly

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Disc space - the final frontier!
