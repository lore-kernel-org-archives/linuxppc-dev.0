From: phandel@cise.ufl.edu
Date: Thu, 19 Oct 2000 13:06:57 -0700 (PDT)
Subject: Re: 2.4.0-test10 boot failure on Powerbook G3
In-reply-to: <39EF2BC1.E464D72F@rational.com>
To: Scott Hankin <shankin@rational.com>
Cc: linuxppc-dev@lists.linuxppc.org
Message-id: <Pine.LNX.4.21.0010191246070.6734-100000@like.mine.nu>
MIME-version: 1.0
Content-type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 19 Oct 2000, Scott Hankin wrote:

> vector: 300 at pc = c016d060, lr = c016c8f4, msr = 9032, sp = c07b1cc0
> [c07b1c10]
> dar = 7ac, dsisr = 40000000
> current = c07b0000, pid = 1, comm = swapper
> mon>

As Ben has suggested, take a look in the System.map file that was created
to see where the problem is.  I've seen the same thing on my PowerCenter,
and it turned out to be in do_fork(), but I haven't had the time to check
out why that is dying.


Thanks,
Peter


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
