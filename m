Message-ID: <378F7957.32142D95@arcormail.de>
Date: Fri, 16 Jul 1999 19:26:41 +0100
From: Michael Fenske <michael.fenske@arcormail.de>
Reply-To: michael.fenske@arcormail.de
MIME-Version: 1.0
To: Lucas Vergnettes <lucas@promac.org>
CC: linuxppc-dev@lists.linuxppc.org
Subject: Re: Kernel compilation problem on YDL
References: <199907150514.AAA14214@lists.linuxppc.org> <v04210100b3b4a639e94b@193.250.81.35>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Lucas Vergnettes wrote:
> 
> Hi!
> 
> I just installed YDL 1.0 some weeks ago. I can comppile every sort of
> software really cleanly, but the kernnel compilation gives me this
> error :
> 
--- snip ---
> arch/ppc/kernel/kernel.o: In function `sys_mmap':
> arch/ppc/kernel/kernel.o(.text+0x4128): undefined reference to `fget'
> make: *** [vmlinux] Error 1
> root:/usr/src/linux#
> 
Please search in the archive at http://lists.linuxppc.org/. I'm sure the
answer is there.

Michael

[[ This message was sent via the linuxppc-dev mailing list.  Replies are ]]
[[ not  forced  back  to the list, so be sure to Cc linuxppc-dev if your ]]
[[ reply is of general interest. Please check http://lists.linuxppc.org/ ]]
[[ and http://www.linuxppc.org/ for useful information before posting.   ]]
