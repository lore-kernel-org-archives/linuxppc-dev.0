Return-Path: <matthias.transier@gmail.com>
Received: from wproxy.gmail.com (wproxy.gmail.com [64.233.184.195])
	by ozlabs.org (Postfix) with ESMTP id 9FA5D688F3
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  4 Jan 2006 22:34:04 +1100 (EST)
Received: by wproxy.gmail.com with SMTP id 69so2294112wra
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 04 Jan 2006 03:34:02 -0800 (PST)
Message-ID: <b789c2e60601040333o42d64c52n@mail.gmail.com>
Date: Wed, 4 Jan 2006 12:33:58 +0100
From: Matthias Transier <matthias.transier@gmail.com>
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Subject: Segmentation fault with X.org and Coral-P drivers
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello everybody,

I have been trying to get X.org running on a board called "Embedded
Planet EP5200C" (it seems to be a "Freescale Lite5200") and a Fujitsu
Coral-P (Rev 5.0). I am using the 2.4 kernel from denx.de and
succesfully installed gentoo-ppc on nfs. The framebuffer works, I get
a login prompt on the monitor.

Now I compiled x.org-6.8.2 (gentoo -r4) and the mb86290 driver from
denx.de. Unfortunately, it does not work and I get a segmentation
fault when trying to startx. strace produces the output attached
below.

Can anybody give me a hint how to proceed?

Regards,
Matthias


[...]
mmap(NULL, 33554432, PROT_READ|PROT_WRITE, MAP_SHARED, 6, 0) =3D 0x30042000
ioctl(6, FBIOGET_VSCREENINFO, 0x105dfa58) =3D 0
ioctl(6, FBIOPUT_VSCREENINFO, 0x105df9b8) =3D 0
ioctl(6, FBIOGET_FSCREENINFO, 0x105df974) =3D 0
ioctl(6, FBIOGET_VSCREENINFO, 0x105df9b8) =3D 0
ioctl(6, FBIOBLANK, 0x1)                =3D 0
ioctl(6, FBIOPAN_DISPLAY, 0x105df9b8)   =3D 0
write(0, "(=3D=3D) MB86290(0): Backing store d"..., 40) =3D 40
write(0, "(II) MB86290(0): Using XFree86 A"..., 63) =3D 63
write(0, "\tScreen to screen bit blits\n", 28) =3D 28
write(0, "\tSolid filled rectangles\n", 25) =3D 25
write(0, "\t8x8 mono pattern filled rectang"..., 36) =3D 36
write(0, "\tIndirect CPU to Screen color ex"..., 40) =3D 40
write(0, "\tSolid Lines\n", 13)         =3D 13
write(0, "\tDashed Lines\n", 14)        =3D 14
write(0, "(II) MB86290(0): Acceleration en"..., 38) =3D 38
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
ioctl(6, FBIOPUTCMAP, 0x7ffff930)       =3D 0
--- SIGSEGV (Segmentation fault) @ 0 (0) ---
rt_sigaction(SIGSEGV, {SIG_IGN}, {0x100424d0, [SEGV], SA_RESTART}, 8) =3D 0
write(2, "\n   *** If unresolved symbols we"..., 112
[...]
