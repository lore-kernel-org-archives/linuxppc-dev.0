Date: Mon, 19 Nov 2001 00:06:56 +0000 (GMT)
From: Phillip Lougher <phillip@lougher.demon.co.uk>
To: Shie Erlich <shie_e@elbit.co.il>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: console prints garbage during boot process
In-Reply-To: <937610FE9B70D511B3E700508B8B65770E53B7@MAIL1>
Message-ID: <Pine.LNX.4.21.0111190002030.1214-100000@lougher.demon.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sun, 18 Nov 2001, Shie Erlich wrote:

>
> during the initial boot process (right after start_kernel calls
> console_init), the kernel
> starts to blurt garbage to the screen. since i needed a temporary hack to
> get me going
> i made console_init() init the serial console with {9600, 8n1, no flow
> control ...).
> although this is the correct setup (since minicom "talks" to the bootrom on
> these settings)
> i still get garbage. i thought that serial_console_setup() has something to
> do with it, but apparently not.
>
> any ideas ?

Without more info it's rather difficult to say.

Do you only get garbage, or do you get some expected text plus garbage?

What I'd do in this situation, is to write a routine that directly prints to the
serial port registers (I daresay it's a 16550 lookalike?).  In that way, you'd
pin-point whether the hardware's not setup/memory mapped correctly, or if
it's problem with the kernel console/printk stuff.

Phillip

----
Phillip Lougher
Zarlink Semiconductor, Wales.

>
> 		thanks,
> 			Shie Erlich
>
>


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
