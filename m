MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <16544.4592.978105.177882@cargo.ozlabs.ibm.com>
Date: Tue, 11 May 2004 09:36:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: Amit Shah <amitshah@gmx.net>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
In-Reply-To: <c7nb0l$5e3$1@sea.gmane.org>
References: <c7nb0l$5e3$1@sea.gmane.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Amit Shah writes:

> I was wondering if SMP is supported for the 750 GX processor built on the
> Marvell Discovery boards.

SMP is not supported for 750 processors.

> If not, what's the problem in getting it supported? An older mail by Cort
> Dougan said it was because of TLB invalidate information not being
> broadcasted, but it was a really old mail, has anyone come up with any
> workarounds?

The real killer is that the cache management instructions are not
broadcast.  The fact that the TLB invalidations are not broadcast is
painful but it can be worked around in the kernel.  In contrast, the
cache management instructions are used in userspace.

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
