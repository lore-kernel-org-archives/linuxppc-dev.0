Date: Fri, 26 Jan 2001 13:39:41 -0500
From: Josh Huber <huber@alum.wpi.edu>
To: Linux/PowerPC Devel List <linuxppc-dev@lists.linuxppc.org>
Subject: Graphics corruption with XF
Message-ID: <20010126133941.A7973@missioncriticallinux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I threw an old Mac64 (VGA compatible controller: ATI Technologies Inc
3D Rage I/II 215GT) into my dual g4 box.  after running X -configure,
I get a semi-working XF86config file.  After tweaking it further, I
still have some problems:

X reports that it could only find 1 MB of video memory, when I'm
pretty sure it's got 4 MB.  This of course severly limits my
depth/resolution, and when paired with the rage 128 I'm currently
using it's a little lacking.. :)

The real problem is that there seem to be some issues with the ati
driver with respect to this card.  The problem definately seem to be
endian related and affect both graphics and text.

Text is corrupted such that the characters are a mirror image of each
other (swapped on the y-axis).  Graphics are fuzzy, and the cursor is
definately corrupted.

Has anyone had any luck with a combination like this?

FYI:
XFree86 Version 4.0.2 / X Window System
(protocol Version 11, revision 0, vendor release 6400)

(II) ATI: ATI driver (version 6.2.3) for chipsets: ati

[huber@dualg4:~]-$> uname -a
Linux dualg4 2.4.1-pre10 #1 SMP Fri Jan 26 11:44:30 EST 2001 ppc
unknown

Thanks,

--
Josh Huber
1024D/6B21489A 61F0 6138 BE7B FEBF A223  E9D1 BFE1 2065 6B21 489A

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
