Message-ID: <3F8B32D6.2030208@ixiacom.com>
Date: Mon, 13 Oct 2003 16:18:46 -0700
From: Dan Kegel <dkegel@ixiacom.com>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: oops logging enhancements for ppc?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm interested in improving oops logging for ppc.
Two enhancements come to mind:

1. Log a few bytes of instruction space like other
architectures do, e.g.
http://lists.linuxppc.org/linuxppc-dev/199812/msg00109.html

2. Log module names and address ranges, as Andrea Arcangeli
proposed in
http://marc.theaimsgroup.com/?l=linux-kernel&m=102772338115172&w=2
and currently implements with the patch
http://www.kernel.org/pub/linux/kernel/people/andrea/kernels/v2.4/2.4.23pre6aa3/90_module-oops-tracking-3

Is anyone aware of improvements along those lines,
or does anyone have objections to this sort of change,
before I dive in and implement them for the latest 2.4 for ppc?

(See also my post today to lkml,
http://marc.theaimsgroup.com/?l=linux-kernel&m=106608037825960&w=2
about making ksymoops aware of Andrea's enhanced oops logging. )

Thanks!
- Dan


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
