Date: Mon, 25 Feb 2002 16:18:45 -0800
From: David Ashley <dash@xdr.com>
Message-Id: <200202260018.g1Q0Ijr02778@xdr.com>
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux 2.4.17 bug, mmap of /dev/mem
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I got 2.4.8 working, and it doesn't exhibit the mmap problem.

2.4.8 has other issues, like it doesn't report bogomips properly:
processor       : 0
cpu             : 82xx
core clock      : 166002750 MHz
CPM  clock      : 132802200 MHz
bus  clock      : 66401100 MHz
revision        : 1.1 (pvr 0081 0101)
bogomips        : 1507.32
zero pages      : total: 0 (0Kb) current: 0 (0Kb) hits: 0/0 (0%)

So: 2.4.8 does not have the mmap problem, 2.4.10 does have the mmap
problem. I'll try 2.4.9 now...

-Dave

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
