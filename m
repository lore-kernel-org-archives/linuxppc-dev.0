Date: Wed, 6 Aug 2003 12:55:17 +0200
Message-ID: <3F30AF4800000549@mssbzhh-int.msg.bluewin.ch>
In-Reply-To: <3F30BEFF.9060207@devcom.cz>
From: "Wolfgang Grandegger" <wolfgang.grandegger@bluewin.ch>
Subject: RE: Console on frame buffer for mpc823
To: "Jan Damborsky" <jan.damborsky@devcom.cz>,
	linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hello,

try booting with the Linux boot argument:

  console=tty0

Good luck.

Wolfgang.


>-- Original Message --
>Date: Wed, 06 Aug 2003 10:40:31 +0200
>From: Jan Damborsky <jan.damborsky@devcom.cz>
>To: linuxppc-dev@lists.linuxppc.org
>Subject: Console on frame buffer for mpc823
>
>
>  Hello,
>
>I use custom board with MPC823 and TFT display
>connected directly to TFT processor interface.
>I would like to use display as console on framebuffer
>when booting and running Linux.
>I use Linux distribution from ElinOS (version 2.0),
>kernel 2.4.3 running busybox on it.
>I successfully compiled in kernel support for framebuffer on /dev/fb/0
>(trying command ¨*dd if=/dev/urandom of=/dev/fb/0 count=100¨* is working
>as expected)
>but console always works on serial channel SMC1.
>How to make kernel use console on /dev/fb/0 ?
>I have attached output of *dmesg *command as well as
>*.config* file.
>                          Thanks in advance, HANYS
>
>
>Attachment: dmesg.out
>
>
>Attachment: .config
>


Wolfgang


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
