Content-Type: text/plain;
  charset="us-ascii"
From: Skip Gaede <sgaede@attbi.com>
To: linuxppc-dev@lists.linuxppc.org
Subject: Memory leak
Date: Thu, 20 Jun 2002 03:52:32 -0400
MIME-Version: 1.0
Message-Id: <200206200352.32895.sgaede@attbi.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Folks,


I'm looking for a recipe on how to track where my memory is
disappearing to. I am running kernel 2.4.19-pre10-ben0,
patched for the nubus-pmac platform. I have 40 MB RAM and a
100 MB swap file on the local hard disk.


I am using the MkLinux booter and the kernel with an initrd.
During the first init, I get an IP address and the path to
the NFS root. I then do a pivot-root, and run the XFree86
Server -query 192.168.0.1, where I do an autologon, and
start up KDE 3.0.1 and Mozilla 1.0 running Choffman's
browser buster. I also am running the snmp daemon, so I can
monitor memory use from my server with a perl script.


When first booted, the kernel takes about 16 MB of memory,
and after starting the X server, I have about 2000k
available physical memory, and no swap file usage. Over
the next 7 hours, I eat up about 20 MB of swap file, and at
some point the available physical memory drops down to
about 150k for about an hour and then the system locks up.
During the same period of time, I can monitor memory use on
the client on another console, and the amount of memory
allocated to each process remains fairly stable up until
lockup.


I'd like to understand what's going on. Can someone suggest
what data I ought to be collecting, or perhaps some
parameters I can tweak to modify the behavior?


Thanks,
Skip


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
