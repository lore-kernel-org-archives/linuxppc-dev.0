From: Michael Thompson <mickey@berkeley.innomedia.com>
Message-Id: <200003091632.IAA29278@berkeley.innomedia.com>
Subject: IDE problems with 2.3.49?
To: linuxppc-dev@lists.linuxppc.org
Date: Thu, 9 Mar 2000 08:32:53 -0800 (PST)
Cc: mickey@berkeley.innomedia.com (Michael Thompson)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>




I've been trying to get version 2.3.49 booted on my B&W G3 (USB/IDE).

It can probe the IDE drives, and they spin up, but it isn't getting
interrupts from IDE0:

	hda: lost interrupt
	hda: lost interrupt
		.
		.
	hdb: lost interrupt
	hdb: lost interrupt

I have been able to boot with a ram disk, and the keyboard works,
so interrupts, in general, are working.

At this point, the problem seems to be isolated to IDE.
Has anyone had success with this?

Btw, I got the kernel from fsmlabs' web-site. It's rtlinux v3 pre 4.

Thanks,

Michael Thompson
mickey@berkeley.innomedia.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
