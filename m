To: "Brian S. Park" <brian@corelis.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: getting Linux working on IBM Walnut demo board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 27 May 2003 11:49:51 PDT."
             <5.1.1.6.2.20030527114004.01282240@corelis.com>
Date: Tue, 27 May 2003 21:53:08 +0200
Message-Id: <20030527195313.187E8C6162@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Brian,

in message <5.1.1.6.2.20030527114004.01282240@corelis.com> you wrote:
>
> I'm trying to boot Linux on IBM Walnut demo board with PPC405GP.
> I download ELDK, installed it on a RedHat Linx 7.3 machine.
> I was able to build u-boot 3.0 which came with ELDK and it booted
> successfully on my demo board.

Fine.

> However, when I tried to rebuild the kernel (2.4.4 which came with ELDK) it
> gives me the following error.

This is a deficiency in the ELDK. For 4xx systems you need  a  recent
kernel.  I  recommend  the linuxppc_2_4_devel tree from the bitkeeper
archives, or from our CVS server.

> Also, the documentation on http://www.denx.de/doc/ seems a bit old (it
> still talks about ppcboot instead u-boot). Are there new ocuments or FAQ's
> for a newbie like me?

There aren't any significant differences between U-Boot  and  PPCboot
if  you're  working  on  PowerPC  systems.  We  are in the process of
setting up new documentation (as a wiki), but this  is  not  complete
yet.

If you have questions or problems, just ask, and we will help you.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Neckties strangle clear thinking.                       -- Lin Yutang

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
