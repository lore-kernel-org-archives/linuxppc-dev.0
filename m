Message-ID: <39EF2BC1.E464D72F@rational.com>
Date: Thu, 19 Oct 2000 13:13:37 -0400
From: Scott Hankin <shankin@rational.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: 2.4.0-test10 boot failure on Powerbook G3
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Howdy -

I've been successfully running 2.4 from Paulus' Linux Kernel Page until
2.4.0-test10 came out.  Now I can't boot at all.  I get the initial
brief
message page and see the messages:

           .
           .
           .
setup_arch: bootmem
arch: exit

then the screen goes black, and I see

vector: 300 at pc = c016d060, lr = c016c8f4, msr = 9032, sp = c07b1cc0
[c07b1c10]
dar = 7ac, dsisr = 40000000
current = c07b0000, pid = 1, comm = swapper
mon>

and everything is dead.  My only option is to cycle power.

I'm running a PowerBook G3 Series (Wallstreet) with 160MB RAM and a 2 GB

partition on a 6 GB disk.  As always, I initially build with the .config
file
that comes over from Paulus' site before making local option changes.

What changed in 2.4.0-test10 (vs. test9) that would explain this?  Since
I am
so early in the boot process (no keyboard control even) I'm at a loss as
to
how to proceed.  Is anyone else successfully running Paulus'
2.4.0-test10 from
a PowerBook?

- Scott

-----------------------------
Scott Hankin (shankin@rational.com)  In the beginning, there was
nothing, then
Rational Software                    God said, "Let there be light."
And there
20 Maguire Road                      was light.  There was still
nothing, but
Lexington, MA 02421                  you could see it a lot better.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
