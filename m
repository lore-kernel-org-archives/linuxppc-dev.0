To: Song Sam <samlinuxppc@yahoo.com.cn>
Cc: Embedded Linux PPC list <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: [patch]Make 2.6.7 kernel "make uImage" work for RPXlite DW 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 18 Jul 2004 06:41:38 +0800."
             <20040717224138.36870.qmail@web15205.mail.bjs.yahoo.com>
Date: Sun, 18 Jul 2004 11:10:06 +0200
Message-Id: <20040718091011.3CBFCC109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20040717224138.36870.qmail@web15205.mail.bjs.yahoo.com> you wrote:
>
> I found that the current 2.6.7 kernel "make uImage"
> can make pass but didn't work with U-Boot on RPXlite
> DW board.This fault is about bd_t,a FAQ in
> DULG-13.2.5.Linux hangs after uncompressing the
> kerne.So I make a patch against bk linuxppc-2.5 tree
> as following.Wolfgang,could you check it?

Sorry, I cannot. I don't have write permision on the  BK  trees.  Try
submitting a patch to this list oand/or the maintainers.

> 1.Why 2.6.x kernel still use ppcboot.h rather than
> u-boot.h?Anyway,ppcboot is a past thing.

You are right. Probably nobody bothered to submit a patch.e

> 2.Could <asm/ppcboot.h> include in rpxlite.h or
> <BOARD.h> to replace bd_t a better idea all the time?

Don't assume that everybody wants to use U-Boot. Maybe this  should be
made dependent on CONFIG_UBOOT like they did for the 5200 [in 2.4].

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"We all agree on the necessity of compromise. We just can't agree  on
when it's necessary to compromise."
                - Larry Wall in  <1991Nov13.194420.28091@netlabs.com>

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
