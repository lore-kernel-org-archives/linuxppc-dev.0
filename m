To: Ralph Siemsen <rsiemsen@rossvideo.com>
Cc: PPC_LINUX <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Init hangs 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Aug 2004 07:22:33 EDT."
             <411369F9.5060506@rossvideo.com>
Date: Fri, 06 Aug 2004 14:46:34 +0200
Message-Id: <20040806124639.3E765C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <411369F9.5060506@rossvideo.com> you wrote:
>
> This could also be a floating point issue.  Most code compiled against
> libc will try to "reset" the floating point state upon startup.  This
> will cause a fault if you do not have a kernel floating point emulator

No, this has nothing to do with it.

First, Marco wrote that he is working on a 8270 processor which has a
FPU, so FP issues should not play a role here.

Second, he mentioned that he was using the ELDK which takes  care  of
using soft-float on processors without a MMU.


Thanks.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The following statement is not true.  The previous statement is true.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
