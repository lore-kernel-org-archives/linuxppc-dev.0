To: Brian Hawley <bhawley@luminex.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Ebony Board, PPC440GP and NFS panics 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 19 May 2004 10:16:29 PDT."
             <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com>
Date: Wed, 19 May 2004 21:54:00 +0200
Message-Id: <20040519195405.98971C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4.2.2.20040519101456.0509d340@bhawley.mailhost.luminex.com> you wrote:
>
> Is there something special that must be done for the kernel to be
> configured for use
> with u-boot?  A kernel config option, perhaps?

See the README file in the U-Boot source tree.  No,  this  is  not  a
kernel config option for most boards.

> I double checked the include/asm-ppc/u-boot.h in u-boot against
> include/asm-ppc/ppcboot.h in linux...and
> did find a section with a #define for CONFIG_405, but not 440.  We'll see
> if that makes a difference.

The question is: does your "arch/ppc/platforms/ebony.h" include
<asm/ppcboot.h> or not, i. e. does it use the U-Boot definitions at
all?

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Of all the things I've lost, I miss my mind the most.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
