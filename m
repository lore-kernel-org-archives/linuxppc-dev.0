Date: Sun, 9 May 2004 13:51:11 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: how to move off of using devfs with the 2.6 kernel
Message-ID: <Pine.LNX.4.58.0405091348290.19145@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


  here's another issue i'd like to resolve.  currently, in moving up to
the 2.6 kernel, i'm trying to do this as gently as possible so i retained
the devfs filesystem, even though it's marked as obsolete in 2.6.  (during
the boot process, i am getting:

  Mounted devfs on /dev
  Freeing unused kernel memory: 76k init

so it seems to still be feasible to use it.  but what's the quickest
reconfiguration to move off of devfs onto (i'm assuming) sysfs and udev?
is it really just a simple kernel reconfiguration?  thanks.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
