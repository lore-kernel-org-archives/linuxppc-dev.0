Message-ID: <20000229214959.9438.qmail@web1004.mail.yahoo.com>
Date: Tue, 29 Feb 2000 13:49:59 -0800 (PST)
From: Dan Bethe <dan_bethe@yahoo.com>
Subject: Re: PCI Bus not recognizing cards properly
To: linuxppc-dev@lists.linuxppc.org, linuxppc-user@lists.linuxppc.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



> My only caveat is that the 100 Mbit ethernet card seems to be choking
> on
> the bandwidth.   The Machine is a 7600/132.   Is this too slow to
> properly
> handle 100Mbts?  Transfers of files via netatalk seem to be very
> slow, far
> slower than using the built in PowerMac ethernet.

	All I can think of is the fact that the kernel source configuration
has an option for "cpu too slow for bandwidth".  Maybe you should check
that out.  Do a "make xconfig" and click on its help option.

=====
"Don't expect your own messiah; this neverworld which you desire is
only in your mind." -- http://www.dreamtheater.net/songb4.htm#IV5

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
