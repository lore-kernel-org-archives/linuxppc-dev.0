Date: Tue, 7 Sep 1999 10:43:15 +1000
Message-Id: <199909070043.KAA01407@tango.anu.edu.au>
From: Paul Mackerras <paulus@cs.anu.edu.au>
To: toa@pop.agri.ch
CC: jquinn@nortelnetworks.com, linuxppc-dev@lists.linuxppc.org,
        linux-kernel@vger.rutgers.edu
In-reply-to: <37D3A439.3A41F55@pop.agri.ch> (message from Andreas Tobler on
	Mon, 06 Sep 1999 13:23:41 +0200)
Subject: Re: MO-Disk on PPC with 53C94 SCSI-chip
Reply-to: Paul.Mackerras@cs.anu.edu.au
References: <37BC482D.7EB2A4AF@pop.agri.ch> <14273.21611.490430.724369@gargle.gargle.HOWL> <37D3A439.3A41F55@pop.agri.ch>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> and second, a mac53c94 driver which may have some bugs.

I wrote the mac53c94 driver a long time ago and I haven't spent
anything like as much time on it as on the mesh driver (which isn't
perfect either).

The opportunity is sitting there, waiting for someone to pick it up,
to stress-test, debug and optimize the mac53c94 driver, including
doing things like implementing disconnect/reconnect.  In the Open
Source tradition, this should be someone for whom this is an itch that
they want to scratch. :-)

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
