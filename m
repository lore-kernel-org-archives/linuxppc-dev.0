Return-Path: <wd@denx.de>
Received: from mailout11.sul.t-online.com (mailout11.sul.t-online.com
	[194.25.134.85]) by ozlabs.org (Postfix) with ESMTP id 4BB8D2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Sun, 14 Nov 2004 07:28:51 +1100 (EST)
To: "Chris Down" <chris@alcor.co.uk>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 13 Nov 2004 11:54:31 GMT."
	<000d01c4c977$8951b0e0$0101a8c0@alcor1>
Date: Sat, 13 Nov 2004 20:27:57 +0100
Sender: wd@denx.de
Message-Id: <20041113192802.C6DFEC1430@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: Problem bringing up Linux on Custom MPC852 Board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <000d01c4c977$8951b0e0$0101a8c0@alcor1> you wrote:
> 
> I have ported u-boot, modified Linux to add a new board config and added the
> board specific definitions in arch/ppc/platforms. 
...
> When I boot Linux I get the following:-
...
> At this point it stops executing in arch_kernel_thread.

I bet some beer that this is actually a FAQ - see
http://www.denx.de/twiki/bin/view/DULG/LinuxCrashesRandomly

This phenomenon is typical for a novice's port of U-Boot.

Best regards,

Wolfgang Denk

-- 
See us @ Embedded/Electronica Munich, Nov 09 - 12, Hall A.6 Booth 513
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"There are things that are so serious that you can  only  joke  about
them"                                                    - Heisenberg
