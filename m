Subject: Re: MPC5200 LEDs
From: Richard Danter <richard.danter@ntlworld.com>
To: Steve Kaiser <steven.kaiser@ucr.edu>
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <200405181550.AYL88709@sentry.ucr.edu>
References: <200405181550.AYL88709@sentry.ucr.edu>
Content-Type: text/plain
Message-Id: <1084959635.2028.4.camel@troll>
Mime-Version: 1.0
Date: 19 May 2004 10:41:06 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Steve,

On Tue, 2004-05-18 at 16:50, Steve Kaiser wrote:
> Before I plow into it, I ask for your advice.  What is the best way to turn
> on/off the status LEDs on the Motorola Lite5200 ("IceCube") board?

I don't know anything about the 5200 board, but I recently wanted to do
the same thing with the LED's on the Wind River (EST) SBC8260 board.

The LED's on this board are write-only at a specific address. My
solution was to write a simple loadable module (like a device driver,
but not statically linked to the kernel). Once loaded, any application
can write to the LED's by writing to the module in /dev.

I can send you my code as an example if you want it.

Rich


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
