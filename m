Message-Id: <200003190946.KAA00356@piglet.grunz.lu>
Date: Sun, 19 Mar 2000 10:46:24 +0100 (CET)
From: Michel Lanners <mlan@cpu.lu>
Reply-To: mlan@cpu.lu
Subject: Re: dmasound split
To: geert@linux-m68k.org
cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.05.10003140902060.19873-100000@callisto.of.borg>
MIME-Version: 1.0
Content-Type: TEXT/plain; CHARSET=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi Geert,

On  14 Mar, this message from Geert Uytterhoeven echoed through cyberspace:
> No comments whether it works on PowerMac and Atari?
> I'd like to let this go in 2.4.0, since a driver for the Q40 is soon to be
> added.

With all the latest patches applied:

1. compiled-in doesn't work; it seems the low-level parts are not
initialised:

Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-slot-0, errno = 2
Mar 19 08:54:33 piglet kernel: kmod: failed to exec  -s -k sound-service-0-6, errno = 2

2. generic sound support compiled-in, PowerMac dmasound as a module:
kernel doesn't boot (hangs somewhere very early, drops me back onto
OF's screen)

3. sound & dmasound as modules: seems to work ok AFAICT. I don't have
any real sound apps to test, except system beep and using the mixer ;-)

Sorry I've not looked in more detail what's wrong, but I'm on other
subjects at the moment...

Michel

-------------------------------------------------------------------------
Michel Lanners                 |  " Read Philosophy.  Study Art.
23, Rue Paul Henkes            |    Ask Questions.  Make Mistakes.
L-1710 Luxembourg              |
email   mlan@cpu.lu            |
http://www.cpu.lu/~mlan        |                     Learn Always. "


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
