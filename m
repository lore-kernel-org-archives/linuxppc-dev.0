From: "Brian Padalino" <bpadalino@perigee.com>
To: "Linuxppc-Embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: 440GP + BDI2000
Date: Thu, 27 Nov 2003 19:03:56 -0500
Message-ID: <DGEEIPOFGGPOACEFBGGCEECJCBAA.bpadalino@perigee.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi folks,

I am using a BDI2000 to try to debug a custom board with a 440GP on it as
well as gigabit ethernet.  I figure I will run U-Boot for my bootloader and
then use that to start up a Linux kernel.

I am able to connect to the custom board and flash the bootloader into
place, but then the fun starts.  I am using the bdiGDB version of the BDI,
but I am very new to GDB.  I downloaded DDD to help me out a bit, and that
seems to work better, but I am still having some troubles.

First of all, I can set hardware breakpoints, and I know I am limited to 2
of them -- but if I use the 'c' command to 'continue', the BDI never
responds back and when I finally stop the CPU over the telnet session -- the
code has already executed something it didn't want to.

Also, I have different sections where the code dies -- and the only common
thing about the different places is the fact that they are ALL return
statements.  This makes me think that my stack is being blased somewhere,
but I don't know how to read where the stack is pointing before I execute
those return statements or to follow the stack in GDB/DDD.

Lastly, in U-Boot, I have to define a setting to write to the debug
registers to acknowledge the BDI and give the BDI control.  Is this
necessary if I end up deciding I don't want to use U-Boot for a bootloader?
Does the BDI require those debug ports to be written to before it can take
over and insert the instructions over the JTAG?

Most of the times, the errors I get are 0x0700 or ox1400 -- which I have
been told are wrong op codes or a tlb miss that isnt handled.

This is my first board I am ever bringing up and this is my first time with
such a sophisticated CPU so _any_ information that anyone can give to me
about this subject would be great.  I have been reading the documentation as
much as I can, but there is so much in the 1666 page IBM document that I
oftentimes feel overwhelmed.

Thanks and everything is appreciated.

Sincerely,
Brian Padalino

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
