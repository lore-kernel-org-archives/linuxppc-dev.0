Message-ID: <39AB60E2.40872E08@research.canon.com.au>
Date: Tue, 29 Aug 2000 17:06:10 +1000
From: Coenraad Jacobsz <cjj@research.canon.com.au>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: DHCP client - report back
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Thanks to Chris Hallinan and Joe Green for their replies.  We chose
'pump' from MontaVista and it works well.  (Had to recompile for our
system)

A few things to remember when using pump are:

1. Make sure the kernel is compiled with CONFIG_PACKET defined

2. If you "pump -k" to kill the interface, and want to manually
   start it again with hard coded IP's, make sure the flags are
   set correctly to bring the interface back up:

      struct ifreq ifr;
      ifr.ifr_flags |= (IFF_UP | IFF_RUNNING);
      ioctl(sd, SIOCSIFFLAGS, &ifr);

This may save some time

Regards
Coenraad

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
