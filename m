Date: Thu, 13 Sep 2001 00:37:01 +0100
From: Chris Emerson <chris@tartarus.org>
To: linuxppc-dev@lists.linuxppc.org
Subject: sys_[rt_]sigreturn bits in entry.S?
Message-ID: <20010913003701.A27914@ixion.tartarus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Can anyone explain why sigreturn/rt_sigreturn are treated specially in
entry.S (and why the strange constants)?

And in particular, is there a good reason why they bypass the ptrace
system call tracing?  It's being a bit of a pain for user-mode Linux on
ppc.

Cheers,

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
