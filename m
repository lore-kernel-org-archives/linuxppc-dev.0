Message-ID: <20040511030852.15275.qmail@web21409.mail.yahoo.com>
Date: Mon, 10 May 2004 20:08:52 -0700 (PDT)
From: Huailin Chen <chen_huailin@yahoo.com>
Reply-To: huailin@xtrj.org
Subject: Re: IBM 750GX SMP on Marvell Discovery II or III?
To: Paul Mackerras <paulus@samba.org>, Amit Shah <amitshah@gmx.net>
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <16544.4592.978105.177882@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


750 series with MEI protocol is a dog for
Multi-Processor system. If you are working for a
high-end products, change it NOW to G4+. 750 is G3.

GT64260 is not good enough for MP yet. Someting
related to 60xbus vs. MPX.

Anyway, right, for PPC MP system, the best way is:
64360 + G4

Also, try to read latest errota when doing the design.

Huailin,

> > If not, what's the problem in getting it supported? An older mail by
> > Cort Dougan said it was because of TLB invalidate information not
> > being broadcasted, but it was a really old mail, has anyone come up
> > with any workarounds?
>
> The real killer is that the cache management instructions are not
> broadcast. The fact that the TLB invalidations are not broadcast is
> painful but it can be worked around in the kernel. In contrast, the
> cache management instructions are used in userspace.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
