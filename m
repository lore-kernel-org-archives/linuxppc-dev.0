Message-ID: <38491C0F.8934B801@wanadoo.fr>
Date: Sat, 04 Dec 1999 14:50:07 +0100
From: Martin Costabel <costabel@wanadoo.fr>
MIME-Version: 1.0
To: linuxppc-dev@lists.linuxppc.org
Subject: arch/ppc/math-emu ?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>



Is the code in arch/ppc/math-emu ever used by anyone? I am asking out of
pure curiosity, seeing that in the latest 2.3.xx kernels this code still
uses things like current->tss that went out of fashion a long time ago.
It doesn't look like it would compile. So what is this anyway?

--
Martin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
