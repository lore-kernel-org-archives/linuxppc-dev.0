Message-ID: <3DF8A803.47AC339D@midrivers.com>
Date: Thu, 12 Dec 2002 08:15:15 -0700
From: Mark Pilon <mpilon@midrivers.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: no segv running under gdbserver, segv without
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi,

I'm trying to debug our apps running on a 405pm target --

when the app is interrupted w/ a ctrl/C it's supposed to
cleanup and quit gracefully, as it does under X86.

it's seg faulting.

when I run it under gdbserver it seems to behave correctly
and I can't catch the failure.

any suggestions?

Thanks,

Mark

--
Mark Pilon
Minolta-QMS

P.O. Box 37
325 Dawson County Road 227
Fallon, MT.  59326-0037
1-406-486-5539 (primary voice line)
1-406-853-0433 (cell)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
