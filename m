To: James Don <JDon@spacebridge.com>
Cc: "'linuxppc-embedded@lists.linuxppc.org'" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: kernel 2.4 smc1 problems ... advice please ... 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 14 Dec 2002 14:37:06 EST."
             <DB0585C9F6F9D411BE8F00D0B7896A4CC05F11@SNCMAIL>
Date: Sat, 14 Dec 2002 22:13:32 +0100
Message-Id: <20021214211337.0CF9FC6139@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <DB0585C9F6F9D411BE8F00D0B7896A4CC05F11@SNCMAIL> you wrote:
>
> I am cuurently trying to boot up the linux kernel using ppcboot 1.16 and the
> 2.4 kernel with only smc1 uart support as a start on an MPC860 FADS derived
> board.

Which 2.4 kernel? Please be precise.

> So far I have:
> - ppcboot running great
> - tftpboot graps my kernel puts in RAM
> - bootm starts my kernel ... BUT no serial activity ...

This is a FAQ. See the Q&A section in http://www.denx.de/re/DPLG.html
Either you're passing a wrong bd_info structure,  or  a  wrong  clock
frequency  (see  also  the  PPCBoot  README about the "clocks_in_mhz"
stuff.)

> I am using the vision ICE currently to debug the kernel start up but it has
> a problem stepping through the 'rfi' etc when memory protection is running.

You cannot step through rfi, not with any BDM debugger.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I paid too much for it, but its worth it.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
