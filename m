Message-ID: <387D260B.90576A02@babcockbrown.com>
Date: Wed, 12 Jan 2000 17:10:35 -0800
From: Hugh Caley <hughc@babcockbrown.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: USB Mouse Changed in 2.2.14
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I just got a 2.2.14 kernel compiled from Paul Mackerra's rsync source (thank you
especially Ben Herrenschmidt!).

I have another problem: my USB mouse doesn't seem to work now.  Has the spec
changed?  My XF86Config has

Section "Pointer"
    Protocol    "IMPS/2"
    Device       "/dev/usbmouse"

However, X complains that there is no such device.

/dev/usbmouse seems to be a symlink to hidbp-mse-0

This used to work in 2.2.14pre9.

Hugh


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
