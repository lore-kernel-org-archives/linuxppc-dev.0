Date: Fri, 23 Jul 1999 14:46:47 +0200
To: linuxppc-dev@lists.linuxppc.org
From: Benjamin Herrenschmidt <bh40@calva.net>
Subject: vger 2.2.10 compile failures
Message-Id: <19990723144647.023789@mail.mipsys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm getting link errors when compiling today's vger 2.2.10 with xmon
support enabled:

arch/ppc/xmon/x.o: In function `backtrace':
arch/ppc/xmon/x.o(.text+0x129e): undefined reference to `ret_from_int'
arch/ppc/xmon/x.o(.text+0x12a2): undefined reference to `ret_from_syscall_1'
arch/ppc/xmon/x.o(.text+0x12a6): undefined reference to `ret_from_int'
arch/ppc/xmon/x.o(.text+0x12aa): undefined reference to `ret_from_syscall_1'
arch/ppc/xmon/x.o(.text+0x12ae): undefined reference to `ret_from_syscall_2'
arch/ppc/xmon/x.o(.text+0x12b6): undefined reference to `ret_from_syscall_2'

Apparently, the name of those symbols changed, I'll try to fix xmon here,
but maybe someone already did it (Paul ?)

-- 
           Perso. e-mail: <mailto:bh40@calva.net>
           Work   e-mail: <mailto:benh@mipsys.com>
BenH.      Web   : <http://calvaweb.calvacom.fr/bh40/>




[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
