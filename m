Message-ID: <20040620204028.58544.qmail@web60402.mail.yahoo.com>
Date: Sun, 20 Jun 2004 13:40:28 -0700 (PDT)
From: Dieu Morales <dieumorales@yahoo.com>
Subject: Asiliantfb (Frame Buffer) Driver
To: linuxppc-dev@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Greetings, I am working with the latest 2.6.7 kernel
source on a ppc radstone PPC7A board and have included
the CT69000 frame buffer to attempt to get a vga
console.  However, when I set
conswitchp = &dummy_con;
the video initializes (monitor signal LED turns green
from orange) and I get a green screen on the monitor.
And when I set
vgacon_remap_base = 0xfe000000;
conswitchp = &vga_con;
the video initializes (monitor signal LED turns green
from orange)  and 50% of the time I get nothing on the
monitor and the other 50% of the time I get what looks
to be a screen saver that displays colors fading into
one another (red->green->blue...) for about 10 sec
like some kind of a video test. I placed
vgacon_remap_base at the PCI0 I/O base, is this
correct?
I have added console=tty0 to the kernel command line
and have not identified any other configuration items
needed.  The serial console I/O which I am expecting
to see on the monitor shows the driver initialized
without errors.  Am I missing something in terms of
configuration?  I have also noticed that when using
vga_con no graphics card is detected in vgacon.c so
goto no_vga and conswitchp = &dummy_con;
Would this be related to the problem?

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
