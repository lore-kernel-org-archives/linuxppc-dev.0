Message-ID: <002201c019ae$a1d57a20$0a00010a@paoloweb>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: keyboard+trackball on the SMCx?
Date: Fri, 8 Sep 2000 18:05:37 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


We have a keyboard with trackball with a serial out that we want to connect
and use with the MPC823 based board under Linux.

I wrote the driver that polls the serial and converts its protocol to
standard PS/2 protocol (i'd like to emulate the psaux char-device). This
works fine...

Now, i'm working on the keyboard module, but i dont know how how to enable
the SMCx interrupt when a character (or more) are received, to keep always
in the memory the state of the keyboard from single event messages.

I looked at the m8xx_tty.c code, and it seems to work without interrupts,
but i fear polling because i have to make a thread on the background that
always checks and reads the SMC. And if i loss anything?

Then, i'll have to insert my keyboard driver in some place to replace the
standard one for embedded powerpc... where is the right place to do that?

Please, give me an hint...

Bye,
Paolo Scaffardi.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
