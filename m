Date: Thu, 18 Nov 1999 01:14:40 +0000 (   )
From: John Buswell <johnb@one.net>
Reply-To: webmaster@imaclinux.net
To: imac-linux-announce@egroups.com
cc: linuxppc-dev@lists.linuxppc.org,
        yellowdog-general@lists.yellowdoglinux.com,
        yellowdog-devel@lists.yellowdoglinux.com, imac-linux-devel@egroups.com,
        imac-linux@egroups.com
Subject: iMac 350/DV/DV SE Linux HowTo
Message-ID: <Pine.LNX.3.96.991118010730.21026K-100000@shell>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The team at iMac Linux (http://www.imaclinux.net) has managed to get the
iMac DV to boot linux to a usable point. We have put together a small
howto on how to achieve this Open Firmware boot and how to kludge a root
file system onto your iMac.

You can find the HowTo at:

http://www.imaclinux.net:8080/content/942890525/index_html

The iMac DV currently has ethernet (through the Dec Tulip device driver)
and USB support, and appears to function quite fast as well!

For those interested here is /proc/cpuinfo

processor       : 0
cpu             : 750
temperature     : 0 C
clock           : 400MHz
revision        : 2.2
bogomips        : 797.90
zero pages      : total 0 (0Kb) current: 0 (0Kb) hits: 0/146 (0%)
machine         : PowerMac2,1
motherboard     : PowerMac2,1 MacRISC Power Macintosh
L2 cache        : 512K unified
memory          : 128MB


Please feel free to visit the site.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
