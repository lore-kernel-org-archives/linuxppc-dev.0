Date: Thu, 23 Nov 2000 14:54:56 +0100 (CET)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Hadess <hadess@writeme.com>
cc: Michael Schmitz <schmitz@zirkon.biophys.uni-duesseldorf.de>,
        Avery Pennarun <apenwarr@worldvisions.ca>,
        debian-powerpc@lists.debian.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: apmd and other archs
In-Reply-To: <974986581.3a1d1d55698b0@imp.free.fr>
Message-ID: <Pine.LNX.4.10.10011231439040.3480-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> We have here a big fat hardware difference. A PMU's a PMU, and an APM BIOS's an
> APM BIOS. I'm now working (with help from Joseph Garcia) on an APM library for
> PMUD. It hides PMUD from the libapm-using battery applets. I posted last week a
> first "socket" version that uses the TCP socket on the loopback interface to get
> its information. And I could compile some programs from the apmd distribution
> and battstat with it.

Glad you mention it again - I didn't follow up on that on the spot and had
already forgotten this.

It seems this apm-pmud glue library would solve our problem in user space
entirely (except for apps that directly cat /proc/apm). The battery status
commands to the PMU are sent via /dev/adb and I'm not sure how this can
be safely done from kernel code.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
