Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3AD370AA.93F59622@ixiacom.com>
Date: Tue, 10 Apr 2001 13:44:26 -0700
From: Bryan Rittmeyer <bryan@ixiacom.com>
MIME-Version: 1.0
To: Wolfgang Denk <wd@denx.de>, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader for deeply embedded 405CR
References: <20010407220120.85706281E2@denx.denx.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Wolfgang Denk wrote:

> For the Walnut it should be a simple thing to do:
>
>         make WALNUT405_config
>         make

Hello Wolfgang,

I have built a CVS ppcboot as you suggest, however
it appears to expect being burned into flash
memory.

What I would like to do is GDB-load an ELF ppcboot
into the Walnut's 32MB SDRAM mapped at address 0,
then execute it in place. Then I want to GDB load a
kernel at another higher address, and use ppcboot
to boot it. Is this already possible or will I have
to modify Makefiles, linker scripts, and possibly
code?

Regards,

Bryan

--
Bryan Rittmeyer
mailto:bryan@ixiacom.com
Ixia Communications
26601 W. Agoura Rd.
Calabasas, CA 91302

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
