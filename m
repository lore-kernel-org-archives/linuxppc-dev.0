Message-ID: <00c301bffad2$fbb85120$640a0a0a@server>
From: "Paolo Scaffardi" <arsenio@tin.it>
To: "linuxppc-embedded" <linuxppc-embedded@lists.linuxppc.org>
Subject: FrameBuffer support on PPC Kernels
Date: Mon, 31 Jul 2000 11:24:45 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm writing a framebuffer device for my 8xx PPC platform (a loadable
module). To do this i must enable the framebuffer support on the kernel, to
resolve the calls to "register_framebuffer" of the device.

The problem is that by enabling the framebuffer support on the kernel
(without any other fb driver inside) the kernel doesn't compiles and reports
that "video_init" doesn't exists (called from main.c).

I am using MPC8xx-2.2.13 kernel. With the mvista kernel 2.2.13-7 i have the
same problem and another one when i try to enable "loadable module support".
It can be done because of "init_modules" and other functions that cannot be
referenced by "main.c". Why that? How can i enable the framebuffer support?

Please help me!

- MAY THE PINGUIN B WITH U -

Best regards,
Paolo Scaffardi
AIRVENT SAM s.p.a - RIMINI (ITALY)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
