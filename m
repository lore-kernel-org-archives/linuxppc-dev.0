Date: Thu, 1 Jul 2004 10:45:41 -0400 (EDT)
From: "Robert P. J. Day" <rpjday@mindspring.com>
To: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: getting support for command-line flash partitioning
Message-ID: <Pine.LNX.4.60.0407011037010.15415@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


   looking a bit more into command-line flash partitioning, i noticed
the following, and i just want to make sure i understand the current
state of this feature.

   first, there's a fair amount of support for CONFIG_MTD_CMDLINE_PARTS
in the current denx (2.4.25) ppc kernel; that is, in the source files
under drivers/mtd/maps.  (not yet in rpxlite.c, where i want it, but
it certainly seems straightforward to add it, i'll try that shortly.)

   however, in the current 2.6 kernel bk pull from ppc.bkbits.net,
none of those maps files support that feature yet.  the kernel itself
clearly lets you select that feature, but none of the drivers yet take
advantage of it, if i read it correctly.

   so how is this being added to the files?  as in, who will add this
feature to the individual files, and get it pushed upstream, if that's
what's going to happen?  just curious as to how this feature will
eventually end up in the mainstream.

rday

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
