Content-Type: text/plain;
  charset="iso-8859-1"
From: "Kevin B. Hendricks" <khendricks@ivey.uwo.ca>
To: linuxppc-dev@lists.linuxppc.org
Subject: kernel drivers and ioctls and mutexes?
Date: Wed, 28 Nov 2001 21:42:52 -0500
MIME-Version: 1.0
Message-Id: <20011129024133.EGCO16262.tomts14-srv.bellnexxia.net@there>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Can anyone tell me if your need mutexes to prevent problems when ioctls
initiated from userland that change dev structure values are used in
kernel drivers?

For example in NIC modules a broken link can cause nway_start on some
cards but a userland ioctl can (asynchronously) cause the same things to
happen?  Should I be using mutexes inside the driver to prevent this or is
there some synchronization mechanism I am missing here?  Given how nway
negotiations are started and given them may take a few seconds to
complete, something should shield the nway start routine from being
re-entered.

Thanks,

Kevin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
