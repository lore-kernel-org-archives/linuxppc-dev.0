Subject: FEC performance on the 855T/860T
To: linuxppc-embedded@lists.linuxppc.org (LinuxPPC Embedded Mailing List)
Date: Thu, 29 Jun 2000 22:09:13 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-Id: <20000629120913.8045B5060C@brixi.research.canon.com.au>
From: greyham@research.canon.com.au (Graham Stoney)
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi gang,

Thanks to all your help, our custom 855T hardware is now up and running, and
it's time to do some system profiling & tuning. The first bottleneck to stand
out is that the FEC port isn't going as fast as we'd like. A simple socket
based tcp client/server setup which repeatedly send's from another machine and
simply recv's data without processing it in user space at all only gets just
over 3 Mbytes/s between two machines connected via a 100 Mbps switch.

There was some discussion on the mailing list last December regarding FEC
throughput on the 860T. For example, see:
    http://lists.linuxppc.org/listarcs/linuxppc-embedded/199912/msg00061.html

Our Embedded Planet CLLF860T boards fair even worse, getting around
2.7 Mbytes/s over the FEC, which tells me that it's not a problem with our
hardware. This is less than a third of its theoretical peak, and I'm
wondering if anyone has had a closer look at where the bottleneck with the
FEC lies?

Regards,
Graham
--
Graham Stoney
Principal Hardware/Software Engineer
Canon Information Systems Research Australia
Ph: +61 2 9805 2909  Fax: +61 2 9805 2929

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
