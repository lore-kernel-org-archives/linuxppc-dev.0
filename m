Date: Fri, 19 Nov 1999 12:39:23 +0100
From: Leif Lindholm <leif@datessa.se>
Reply-To: Leif Lindholm <leif@datessa.se>
Message-ID: <19527.991119@datessa.se>
To: linuxppc-embedded@lists.linuxppc.org
CC: Jim Chapman <jim.chapman@iname.com>
Subject: Re: configuring swap on a diskless mpc860 embedded target
In-reply-To: <38351D54.34124FBD@switchboard.ericsson.se>
References: <38351D54.34124FBD@switchboard.ericsson.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>



KJ> A question:
KJ>     Have you ever swapped over nfs on any linux system?  I don't think it
KJ> works.

KJ> The only way I know of is using the network block device and a patch to make
KJ> swapping over that work.

There was a patch for this for the 2.0.2x kernels.

It is available at http://www.vu.union.edu/~hagopiar/linuxnfsswap/ if
someone would like to upgrade it.

regards
/
       Leif


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
