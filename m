Message-ID: <3A4B9BF0.EDC73E37@mvista.com>
Date: Thu, 28 Dec 2000 15:00:48 -0500
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Kwansuk Kim <kskim@neowave.co.kr>
CC: LinuxPPC <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Using gdbserver...
References: <NEBBKFENMLEDKDHMEHPJIECCCCAA.kskim@neowave.co.kr>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Kwansuk Kim wrote:

> I used ethernet on SCC1, and it worked very well except Ctrl-C interrupt.
>
> It didn't worked.

Yep.  That part is missing from the serial port driver.  I finally
got it working in the 8260 sources in 2.3/2.4 and I will shortly update
all of the drivers.  I have lots of KGDB updates for many processor/board
combinations (all slightly different of course), and I am trying to
find some better/common PowerPC KGDB support.

All you can do right now is ensure you have some breakpoints set that
are known to be hit before you type 'continue'.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
