Date: Mon, 16 Sep 2002 15:16:19 -0300
From: Ricardo Scop <scop@vanet.com.br>
Reply-To: Ricardo Scop <scop@vanet.com.br>
Message-ID: <12636.020916@vanet.com.br>
To: Atm account <linux2@cdotd.ernet.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: help needed for porting linux-2.5 to a ppc custom board
In-reply-To: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in>
References: <Pine.OSF.4.10.10209141216080.2765-100000@moon.cdotd.ernet.in>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Atm :-),

A good starting point is
http://penguinppc.org/embedded/howto/PowerPC-Embedded-HOWTO.html.

IMHO, porting a good bootloader/monitor to your board, like PPCBoot,
is half the way to go.

I hope that helps...

Ricardo Scop                            mailto:scop@plugin.com.br

------------------------------------------------------------------
It might look like I'm doing nothing, but at the cellular level I'm
really quite busy.

Saturday, September 14, 2002, 4:34:28 AM, you wrote:

Aa>   We want to run linux on a custom board having ppc603ev.
Aa> We have identified the following tasks :-
Aa> processor-specific tuning,
Aa> board related changes (io_block_mapping, pic etc.)
Aa> serial driver for uart device.
Aa> pci,timer initialisations.

Aa>   There is 4mb flash on the board (for storing vmlinux.gz)
Aa> No hard disk.

Aa>  Since, there is only 1 uart port, how can we use it for
Aa> console-login and dumping printk messages?

Aa>  How should we start identifying changes to be done in
Aa> kernel source (mostly arch/ppc)? Is there any resource
Aa> available on internet for porting linux to a powerpc/any
Aa> board ?

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
