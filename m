Message-Id: <5.0.2.1.2.20010119123352.03511010@mail.munich.netsurf.de>
Date: Fri, 19 Jan 2001 12:40:45 +0100
To: iweiny@pacbell.net
From: Franz Sirl <Franz.Sirl-kernel@lauterbach.com>
Subject: Re: Linux/PPC BitKeeper tree announcements
Cc: linuxppc-dev@lists.linuxppc.org (linuxdev)
In-Reply-To: <200101190150.RAA01825@batcave2.batcave>
References: <20010109161126.P18696@hq.fsmlabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At 02:50 2001-01-19, iweiny@pacbell.net wrote:

>At the risk of sounding stupid I guess I need a newer compiler than egcs for
>the new kernel trees?
>
>fork.c:353: fixed or forbidden register 68 (0) was spilled for class CR0_REGS.
>This may be due to a compiler bug or to impossible asm
>statements or clauses.

You shouldn't be using _anything_ older than gcc-2.95.2 on PPC anymore. In
the meantime the release of gcc-2.95.3 is pending and I would _strongly_
recommend you to use it.
You can find the latest RPM's on
<ftp://devel.linuxppc.org/users/fsirl/glibc-2.1/>, the current revision is
2t, which corresponds to gcc-2.95.3.test2.

Minimum download are the cpp and gcc packages, for C++ you need gcc-c++ and
libstdc++ packages as well.

Franz.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
