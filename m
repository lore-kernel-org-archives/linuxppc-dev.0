Message-ID: <40925BBF.1010708@g-house.de>
Date: Fri, 30 Apr 2004 15:59:27 +0200
From: Christian Kujau <evil@g-house.de>
MIME-Version: 1.0
To: linuxppc-dev list <linuxppc-dev@lists.linuxppc.org>
Subject: rsync'ed sources out of date?
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



hi,

the issue about different kernel-trees was brought up a few month ago,
but i still fail to understand what the "current" tree might be. i use

~ rsync source.mvista.com::

and see various version for 2.4 and 2.5 (ok, it's 2.6., but still left
to be renamed, right?)

fetching via rsync gives (today)

rsync source.mvista.com::linuxppc_2_4       -> 2.4.25
rsync source.mvista.com::linuxppc-2.4       -> 2.4.26
rsync source.mvista.com::linuxppc_2_4_benh  -> 2.4.25-ben1
rsync source.mvista.com::linuxppc_2_4_devel -> 2.4.25
rsync source.mvista.com::linuxppc-2.5       -> 2.6.5
rsync source.mvista.com::linuxppc-2.5-benh  -> 2.6.5-rc3-ben0

that leaves only "linuxppc-2.4" and for 2.6 "linuxppc-2.5"
to fetch from in order to get a recent tree, right? they already differ
from a vanilla 2.4.26 or 2.6.5, but the timestamp for "linuxppc-2.5" for
example says "2004-04-15", so it's obviously not a daily -BK snapshot
(descritiption goes "based on Linus' BitKeeper tree").

so where do i get the most current copy of a 2.4/2.6 kernel for ppc?
is it possible at all with "rsync"?
or shall i go with the -BK snapshots on kernel.org?

(i seem to need a current copy of the kernel, as i still fail to compile
a ppc-kernel with KGDB enabled. see
http://nerdbynature.de/bits/sheep/kgdb/ for make-logs)

thanks for comments,
Christian
- --
BOFH excuse #271:

The kernel license has expired


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
