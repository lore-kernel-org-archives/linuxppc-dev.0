To: Richard Danter <richard.danter@ntlworld.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: bd_t definition changes 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 30 Apr 2004 13:59:42 BST."
             <40924DBE.2010908@ntlworld.com>
Date: Fri, 30 Apr 2004 17:45:39 +0200
Message-Id: <20040430154544.995D4C1356@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <40924DBE.2010908@ntlworld.com> you wrote:
>
> I am trying to boot linux 2.4.24 (from ELDK 3.0) on an EST SBC8260 using
> U-Boot 1.1.1 which I downloaded from the Denx ftp site.
...
> I have discovered that the bd_t (board info) being seen by the kernel
> does not match what it expects. Looking closer at the source, I can see
> that the definition of this structure differs between that in the kernel
> (arch/ppc/platforms/est8260.h) and U-Boot (include/asm-ppc/u-boot.h).

Delete the definition in arch/ppc/platforms/est8260.h and replace  it
by  a  simple  "#include <asm/ppcboot.h>" -- see any other board with
U-Boot support for reference, for example "arch/ppc/platforms/tqm8260.h"


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
If God wanted me to touch my toes, he'd have put them on my knees.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
