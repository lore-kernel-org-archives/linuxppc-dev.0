Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
From: Jeff Kowing <jeffrey.d.kowing@nasa.gov>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16148.1141.101138.214108@igor.jsc.nasa.gov>
Date: Tue, 15 Jul 2003 08:41:09 -0500
To: "Brian Padalino" <bpadalino@perigee.com>
Cc: <linuxppc-embedded@lists.linuxppc.org>
Subject: DENX ELDK Kernel
In-Reply-To: <DGEEIPOFGGPOACEFBGGCOEGKCAAA.bpadalino@perigee.com>
References: <DGEEIPOFGGPOACEFBGGCOEGKCAAA.bpadalino@perigee.com>
Reply-To: jeffrey.d.kowing@nasa.gov
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Brian Padalino writes:
 > I understand that DENX ELDK is always being worked on, and I have seen that
 > Wolfgang Denk is amazingly active in this community, so I guess my question

He's a mythological figure!  I think he is really secretly several
people working as one incredible unit of productivity.

 > is -- can I use the linux-ppc kernel patches for the latest 2.4 kernels
 > instead of DENX's?  Should this requirement of the kernel needing to be
 > easily upgradable to any kernel reevaluated?

Others are more qualified to answer this than me, but, heck, that
never stopped me before!  Basically, the answer is yes - at least I
have been using the ELDK with a linux-2.4.20 kernel (from kernel.org).
The key point to remember is that you should always compile user
applications against the Linux include files that glibc (and all the
rest of the target ELDK apps) are built against - Do NOT compile your
user applications against the newer Linux kernel.

Regards,
Jeff

--
Jeff Kowing <jeffrey.d.kowing@nasa.gov>
All opinions expressed are my own and not of my employer.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
