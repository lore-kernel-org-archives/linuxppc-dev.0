Message-ID: <20040519131316.49507.qmail@web15203.mail.bjs.yahoo.com>
Date: Wed, 19 May 2004 21:13:16 +0800 (CST)
From: Song Sam <samlinuxppc@yahoo.com.cn>
Subject: Re: getting linux console on a frame buffer.
To: Geert Uytterhoeven <geert@linux-m68k.org>,
	David Ho <DavidHo@nanometrics.ca>
Cc: Linux/PPC Development <linuxppc-dev@lists.linuxppc.org>
In-Reply-To: <Pine.GSO.4.58.0405191047150.23702@waterleaf.sonytel.be>
MIME-Version: 1.0
Content-Type: text/plain
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > The problem may be that I don't have a linux console running on the
> > frame buffer device. Would anyone know how to get the linux console
> > on the frame buffer but still receives input from a serial port (I
> > don't have a keyboard attached to the board. I have been doing most
> > things from the serial console and remotely).
>
> Append `console=tty0 console=ttyS0' to the kernel command line, and
> kernel messages will appear on both tty0 (fb) and ttyS0 (serial),
> while console input will be taken from the last one (ttyS0).

But this isn't a solution to have a LINUX console on
the frame buffer with serial port input.It DID output
some boot message to LCD but the work console is still
ttyS0.And you can type a command like "echo a >
/dev/tty0" to make the 'a' to LCD.Without such
command,however,the input result still is displayed on
serial console.Am I right?

Best regards,

Sam

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
