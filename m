To: Mark Hatle <fray@mvista.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: PowerPC 440GP-specific optimization with gcc
References: <87ptplyot4.fsf@love-shack.home.digitalvampire.org>
	<3E57B566.7080800@mvista.com>
From: Roland Dreier <roland@digitalvampire.org>
Date: 22 Feb 2003 11:17:44 -0800
In-Reply-To: <3E57B566.7080800@mvista.com>
Message-ID: <87lm08yvjb.fsf@love-shack.home.digitalvampire.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


    Mark> I am not a tools expert by any means.. but from my
    Mark> understanding there is work to support the 440 specific
    Mark> items.

    Mark> However, I believe the work is focused on enhancing binutils
    Mark> (the assembler) and not the compiler.  So any 440 specific
    Mark> optimizations you would like would need to be written in
    Mark> assembly.  (My multi-month old memory is that the 440's new
    Mark> userspace instructions arn't terribly "generic" to
    Mark> facilitate use in gcc..)

I am not talking about using new 440/Book E instructions.  I am just
referring to generic optimizations such as scheduling instructions to
fit the 440's pipelines as well an possible.  Clearly this would
involve work on gcc, and I am just wondering if anyone has done this.

Thanks,
  Roland

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
