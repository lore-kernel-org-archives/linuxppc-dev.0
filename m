Subject: Re: Could you like to tell me that where I can find the definition
	of "struct pt_regs" in Linux/PPC?
From: Gary Thomas <gary@mlbassoc.com>
To: chenm@cs.man.ac.uk
Cc: linuxppc-dev@lists.linuxppc.org
In-Reply-To: <HLEBJDLEFEKDCJFKLDCEIEBNEDAA.chenm@cs.man.ac.uk>
References: <HLEBJDLEFEKDCJFKLDCEIEBNEDAA.chenm@cs.man.ac.uk>
Content-Type: text/plain
Message-Id: <1089470886.3988.2974.camel@hermes>
Mime-Version: 1.0
Date: Sat, 10 Jul 2004 08:48:07 -0600
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 2004-07-10 at 07:42, Ming Chen wrote:
> Hi, I am porting JikesRVM from PowerPC to ARM.
>
> I can not find the source code of "asm/proc/ptrace.h" and the definition of
> "struct pt_regs" in it.
>
> Could you like to tell me that where I can find the definition of "struct
> pt_regs" in Linux/PPC?

Use the source :-)  In the Linux source tree:

% grep -r pt_regs include
  ...
include/asm-ppc/ptrace.h:struct pt_regs {
  ...

--
Gary Thomas <gary@mlbassoc.com>
MLB Associates


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
