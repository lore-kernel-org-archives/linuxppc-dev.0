Date: Thu, 8 Nov 2001 11:14:01 +0000
From: Chris Emerson <chris@tartarus.org>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: The Plan
Message-ID: <20011108111401.A18221@ixion.tartarus.org>
References: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <15337.7275.266062.777161@cargo.ozlabs.ibm.com>; from paulus@samba.org on Wed, Nov 07, 2001 at 10:35:07PM +1100
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Wed, Nov 07, 2001 at 10:35:07PM +1100, Paul Mackerras wrote:
> (to reduce the arch/ppc/kernel clutter, that is)
>
> This is what I am thinking of; I have implemented it locally here and
> I'm doing test compiles with arch/ppc/configs/*.
>
> - arch/ppc/kernel/ppc_asm.h moves to include/asm-ppc, and the contents
>   of ppc_asm.tmpl get folded into it, with corresponding changes to
>   arch/ppc/*/*.S.

This sounds like a good thing for the user-mode port, which tries to use
a couple of the assembler files from arch/ppc.  There's some hideous symlink
hackery going on to get them to work at the moment.  If it's all just in
include/asm-ppc, that should be much nicer.

Cheers,

Chris

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
