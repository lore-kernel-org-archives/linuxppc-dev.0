Date: Mon, 23 Oct 2000 08:35:01 -0700 (PDT)
From: William Blew <wblew@home.com>
To: Derek Homeier <supas100@astrophysik.uni-kiel.de>
cc: linuxppc-dev@lists.linuxppc.org, Michael Norton <mnorton@cisco.com>
Subject: Re: COPTS for Makefile LinuxPPC 2000
In-Reply-To: <Pine.SOL.3.95.1001023131438.18258B-100000@juliet>
Message-ID: <Pine.LNX.4.10.10010230832490.11593-100000@apollo.kulian.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 23 Oct 2000, Derek Homeier wrote:

> such as"-mcpu=604", don't know if there is a flag for 750 or even 7400 yet.

As of gcc 2.95.2 (at least) there is a -mcpu=750 (or -mtune=750) option
and on my beige G3/266 it was good for about a 11% throughput improvement
on the utah-glx's memory bandwidth benchmarks.

--
William Blew, wblew@home.com
Gamer by Choice, Geek by Birth


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
