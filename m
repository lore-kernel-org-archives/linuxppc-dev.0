Mime-Version: 1.0 (Apple Message framework v618)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <5ADF885A-E00F-11D8-B9F8-000393DBC2E8@freescale.com>
Cc: LinuxPPC-dev <linuxppc-dev@lists.linuxppc.org>
From: Kumar Gala <kumar.gala@freescale.com>
Subject: namespace issues with asm-ppc/regs.h
Date: Tue, 27 Jul 2004 15:55:56 -0500
To: Paul Mackerras <paulus@samba.org>,
	Matt Porter <mporter@kernel.crashing.org>,
	Tom Rini <trini@kernel.crashing.org>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


All,

Viro recently submitted some patches to 2.6 which removed some names
space conflicts that existed between asm-ppc/regs.h (also
asm-ppc64/regs.h) and various drivers.  I'm proposing we remove all non
SPRN_ scoped references for SPRs.  I'm willing to cleanup the ppc32
side for this change, however I would appreciated someone willing to do
the same for PPC64.

Let me know if we want to go down this path or if there is some other
brilliant idea for resolving the namespace issue.

I'm also envious of Viro's ability to get C++ style comments into the
linux kernel :)

- kumar

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
