Message-ID: <0D9416AE7F95D411A8710008C7332F3F054362@GUILDFORD4_NT>
From: Daniel Furse <daniel.furse@iptest.com>
To: "Linux Embedded List (E-mail)" <linuxppc-embedded@lists.linuxppc.org>
Subject: Neighbour table overflow
Date: Mon, 22 Jan 2001 11:33:24 -0000
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi all,

I am getting 'neighbour table overflow' when I try to mount a root
filesystem
via NFS. Eventually the kernel panics and resets.

The NFS server is working correctly, I have verified by mounting on another
linux box.

When linux tries to mount the nfs root filesystem, the activity LED on the
ethernet port on the card stops flashing, this implies that something has
clobbered the phy? Does anyone have any suggestions?

Many thanks,

Dan Furse

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
