Message-ID: <01C33566.E9EA7960.robdlg@att.net>
From: "DeLaGarza, Robert" <robdlg@att.net>
Reply-To: "robdlg@att.net" <robdlg@att.net>
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: matroxfb
Date: Wed, 18 Jun 2003 06:57:35 -0700
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm having a slight problem with a Matrox G450 PCI card.  It's hosted by an Artis SBC-A3000 (it's like a Sandpoint with an
MPC8245).  The kernel is a modifed MontaVista 2.4.19-pre8, and there is no keyboard.

My kernel command line includes:

console=tty0 console=ttyS0,9600
video=matrox:init,vesa:0x105

The card initializes and displays console output, and text redirected to /dev/tty0 also appears.  However, after 5 or so
minutes, the card apparently goes to sleep.  The monitor goes black.  Messages from the kernel do wake the display
up, however.

How can I keep the card from sleeping, if indeed that is what is happening?

Incidentally, while searching the linuxppc-embedded archives, I encountered a question regarding "matroxfb: cannot
determine memory size."  I had the same error, but using "init" in the kernel command line alleviated it.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
