Message-ID: <1070626021.3fd074e539732@mail.theboonies.us>
Date: Fri,  5 Dec 2003 06:07:01 -0600
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: Re: userspace testing an ati fb driver
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
From: David Eger <random-temp_addy-1071230825.92d33e@theboonies.us>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I think this explains my problem;  output from my reg dump:

Radeon MMIO registers:
0000 : 0000c081
0004 : 00313131
0008 : 3f000000
...

output from your reg dump:

Radeon MMIO registers:
0000 : 81c00000
0004 : 31313100
0008 : 0000003f
...

thanks a bunch.

-david

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
