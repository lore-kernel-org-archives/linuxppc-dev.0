Message-ID: <3BC4FF42.CBC7C9DB@india.infogain.com>
Date: Thu, 11 Oct 2001 07:39:06 +0530
From: ashish anand <ashisha@india.infogain.com>
MIME-Version: 1.0
To: Frederic Soulier <soulier@aztec-radiomedia.com>,
	linuxppc-embedded@lists.linuxppc.org
Subject: Re: Numbering of system calls
References: <619D608DD3F0D311882C009027732E1A83626C@ntserver.act.domain> <007601c15223$9b12d440$d8020101@aztec.local>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


look in /usr/src/linux/arch/ppc/kernel/misc.S for syscall numbering...
syscall no. 4 is write -> sys_write


Frederic Soulier wrote:
>
> > Kernel crashes and, among other things, it shows "Last syscall: 4".
> > How can I relate that to actual syscall being executed?
>
> The last syscall message is about the

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
