From: jdweyer@rockwellcollins.com
Subject: /dev/vme Permissions for users other than root...
To: linuxppc-embedded@lists.linuxppc.org
Date: Tue, 22 Jan 2002 16:57:13 -0600
Message-ID: <OFEA27A9BB.3CE5E820-ON86256B49.007E0567@collins.rockwell.com>
MIME-Version: 1.0
Content-type: text/plain; charset="us-ascii"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


(disregard prior email; subject was not included)

Greetings,

We are using Linux version 2.2.12 with Gabriel Paubert's patches for the
Motorola MVME2600 platform.   I have
my application working opening /dev/vme and then doing ioctl calls to set
the attributes.  It works
fine only when I am root.  When another user tries to run the application,
the ioctl (not the open) fails.
I have changed the permissions of /dev/vme to rw for all (ugo) and have
even gone as far as
changing ownership and group to the user's instead of root, but to no
avail.  The permissions
of /dev/vme are crwxrwxrwx.  I realize the execute (x) permission is
ineffective, but I'm trying everything.

Do you have any ideas of what to try?

Thanks for any help you can provide,

JoAnna Weyer


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
