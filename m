Message-Id: <4.3.2.7.2.20000901081743.00b28970@bucks.si.com>
Date: Fri, 01 Sep 2000 08:33:15 -0400
To: linuxppc-embedded@lists.linuxppc.org
From: Jon Diekema <diekema_jon@esseye.si.com>
Subject: Linux kernel modules and the GPL
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I thought that loadable Linux modules avoided the GPL requirements, but
perhaps it doesn't?
I guess you need to go back the GPL license, and understand what a derived
work means.

 From COPYING in the Linux Kernel source:

                    GNU GENERAL PUBLIC LICENSE
                        Version 2, June 1991

0. This License applies to any program or other work which contains
a notice placed by the copyright holder saying it may be distributed
under the terms of this General Public License.  The "Program", below,
refers to any such program or work, and a "work based on the Program"
means either the Program or any derivative work under copyright law:
that is to say, a work containing the Program or a portion of it,
either verbatim or with modifications and/or translated into another
language.  (Hereinafter, translation is included without limitation in
the term "modification".)  Each licensee is addressed as "you".

 From COPYING in the Linux Kernel source:

dell 108} head COPYING

    NOTE! This copyright does *not* cover user programs that use kernel
  services by normal system calls - this is merely considered normal use
  of the kernel, and does *not* fall under the heading of "derived work".
  Also note that the GPL below is copyrighted by the Free Software
  Foundation, but the instance of code that it refers to (the Linux
  kernel) is copyrighted by me and others who actually wrote it.

                         Linus Torvalds


 From http://www.linuxhq.com/lg/issue32/rubini.html

Alessandro: What is your position about the availability of Linux modules
in binary-only form?

Linus: I kind of accept them, but I never support them and I don't like them.

The reason I accept binary-only modules at all is that in many cases you
have for example a device driver that is not written for Linux at all, but
for example works on SCO Unix or other operating systems, and the
manufacturer suddenly wakes up and notices that Linux has a larger audience
than the other groups. And as a result he wants to port that driver to Linux.
But because that driver was obviously not _derived_ from Linux (it had a
life of its own regardless of any Linux development), I didn't feel that I
had the moral right to require that it be put under the GPL, so the
binary-only module interface allows those kinds of modules to exist and
work with Linux.

That doesn't mean that I would accept just any kind of binary-only module:
there are cases where something would be so obviously Linux-specific that
it simply wouldn't make sense without the Linux kernel. In those cases it
would also obviously be a derived work, and as such the above excuses don't
really apply any more and it falls under the GPL license.

------------------\\----------------------\\----------------------------
Jon Diekema        |                       | Smiths Industries
(616) 241-8310     |                       | 3290 Patterson Avenue, SE
diekema_jon@si.com \\                      \\  Grand Rapids, MI 49512-1991


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
