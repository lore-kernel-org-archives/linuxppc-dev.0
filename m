From: Paul Mackerras <paulus@linuxcare.com>
To: linuxppc-dev@lists.linuxppc.org, Geert Uytterhoeven <geert@linux-m68k.org>
Subject: Re: Kernel debugging??
Date: Thu, 18 Nov 1999 13:37:13 +1100
Content-Type: text/plain
References: <Pine.LNX.4.05.9911172207200.25661-100000@callisto.of.borg>
MIME-Version: 1.0
Message-Id: <99111813390003.04211@argo.linuxcare.com.au>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Thu, 18 Nov 1999, Geert Uytterhoeven wrote:

> Are you sure about the version? I just checked out this tree, and it's 2.3.22,
> according to the Makefile. Perhaps I made a mistake? This is the first time I
> used rsync (`rsync -auvz samba.anu.edu.au::linux-pmac-devel .').

There is a 2.3.28 tree in linuxcare.com.au::linux-pmac-devel, which boots
and runs for me but has some sort of major memory leak.  The tree on samba
is old, maybe I should just remove it.  I will be putting stuff on
linuxcare.com.au (== ftp.linuxcare.com.au) generally from now on.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
