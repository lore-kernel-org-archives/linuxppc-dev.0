Message-ID: <3A54BFCF.8EC56F45@mvista.com>
Date: Thu, 04 Jan 2001 13:24:15 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Christian.Peter@ascom.ch
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux boot fails after MMU (MPC8260)
References: <0G6N00K6Y4ZYFB@pmdf-it.hasler.ascom.ch>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Christian.Peter@ascom.ch wrote:
>
> Hi
>
> I try to boot linux 2.4.0test8 on a custom 8260 board.

Where did you get the sources?  There have been some problems with
the 8260 due to other 60x/7xx generic changes in the sources.

> My knowledge of the mmu and the 8260 is not very good,

Don't worry about it.  There is nothing wrong with the MMU code,
it is elsewhere.  If you are trying to use VisionICE or anything
other than the Abatron BDI2000 for JTAG debugging, they become
useless once the MMU is enabled.  This appears like an MMU bug,
but it is really a debugger bug.

For now, the only working version of Linux on the 8260 is from
the MontaVista web site.  It is a -test2 version.  If you have
access to the FSM Labs BitKeeper sources, I will be updating these
for the 8260 before the end of the week.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
