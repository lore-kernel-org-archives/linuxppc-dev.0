Message-ID: <3BE321D5.DAA2FCD4@linux-m68k.org>
Date: Fri, 02 Nov 2001 23:44:37 +0100
From: Roman Zippel <zippel@linux-m68k.org>
MIME-Version: 1.0
To: paulus@samba.org
Cc: linuxppc-dev@lists.linuxppc.org
Subject: Re: APUS irq patch
References: <Pine.LNX.4.33.0111020007080.8971-100000@serv> <15331.5645.328862.515166@cargo.ozlabs.ibm.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

Paul Mackerras wrote:

> Could you describe for us how the APUS interrupt stuff works?  In
> looking at your patch, I found myself thinking "there's got to be a
> better way" but before making any suggestions I want to make sure I
> understand what is being done and why.

APUS emulates the interrupt levels of the m68k, so at interrupt entry we
have to save the current interrupt level, set the new one and restore it
at the exit. There is another possibility to use a local lookup table to
store the previous value. I have to test that...

bye, Roman

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
