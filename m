Message-ID: <3B610FD9.17F01F88@xilinx.com>
Date: Thu, 26 Jul 2001 23:53:13 -0700
From: "Peter Ryser" <Peter.Ryser@xilinx.com>
MIME-Version: 1.0
To: linuxppc-embedded@lists.linuxppc.org
Subject: Re: mmu problems
References: <3B4F412F.99A14D9E@comdev.cc>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hi Adam,

not a solution for your real problem, but I hope it helps anyway.

> Is there any way I can get gcc to annotate the assembly listing with the
> C source
> code?  I feel it would help pinpoint what is going on...

objdump --source vmlinux

produces a mixed C/assembly file. Works only if debugging information has been
included in the kernel during compilation.

- Peter


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
