Date: Sat, 07 Apr 2001 12:42:19 -0700
Subject: Coding device driver for a minor device.
From: Karsten Jeppesen <karsten@jeppesens.com>
To: <linuxppc-dev@lists.linuxppc.org>
Message-ID: <B6F4BBA9.5D29%karsten@jeppesens.com>
Mime-version: 1.0
Content-type: text/plain; charset="US-ASCII"
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I have done modules.

Now the problem is that I have 2 pushbuttons that I would like to read.
Looking in the device list I see dev 10, which has a lot of - let us call it
miscellaneous - content. This one seems to fit here. Maybe as a minor 185 or
186.
But how do I locate the device driver for device major 10?

I am certain there is a simple way - somebody knows it?


Sinserely,
Karsten Jeppesen


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
