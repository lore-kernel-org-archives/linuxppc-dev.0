From: iweiny@pacbell.net
Date: Thu, 18 Jan 2001 17:50:33 -0800 (PST)
Subject: Re: Linux/PPC BitKeeper tree announcements
In-reply-to: <20010109161126.P18696@hq.fsmlabs.com>
To: linuxppc-dev@lists.linuxppc.org (linuxdev)
Message-id: <200101190150.RAA01825@batcave2.batcave>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


At the risk of sounding stupid I guess I need a newer compiler than egcs for
the new kernel trees?

fork.c:353: fixed or forbidden register 68 (0) was spilled for class CR0_REGS.
This may be due to a compiler bug or to impossible asm
statements or clauses.

Ira

--- To quote Cort Dougan: ---
>
>
> We now have a mailing list for the commit messages for the 2.2 and 2.4
> trees.  If you want to keep up on Linux/PPC development take a look at
> http://www.fsmlabs.com/linuxppcbk.html and follow the subscription
> instructions.
>
> I'd like to keep the traffic low on these lists since we have plenty of
> other lists for general discussion.  This lists are just for following
> changes to the kernel and some discussion of those changes.
>
> The 2.3 trees are no longer available via anonymous access as they're been
> replaced with a new 2.4 repository.  The change was necessary to remove the
> 80MB or so of deleted file (as a result cloning, checking out and committing
> changes is much faster).
>
> For those of you who had work in copies of the 2_3 that you were accessing
> anonymously you need not fear your work is lost.  Just generate a diff
> against the last changeset in your repository and reapply it to the 2_4
> tree.
>
>


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
