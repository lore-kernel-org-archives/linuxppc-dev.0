To: dai hongbo <dai@hanwang.com.cn>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux for FADS850? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 09 Feb 2001 10:17:42 +0800."
             <3A835346.E3E9F292@hanwang.com.cn>
Date: Fri, 09 Feb 2001 09:46:07 +0100
Message-Id: <20010209084612.CB2F528162@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Dai,

in message <3A835346.E3E9F292@hanwang.com.cn> you wrote:
>
>   i got a FADS850 board,tried to get linux running on it.
>   i found a lot linux claimed supporting ppc,however,no one has a option for
> FADS850.
>  is there a linux version working on FADS850?if it exists,where is it?
>   and could you give some advice?

I think MontaVista has an old version  of  a  2.4  kernel  with  FADS
support on their FTP server in /pub/Area51.

Some people were able to get it running, so give it a try -  I  don't
have any personal experience since we don't use FADS boards.

However, full FADS support is available in PPCBoot, our  Open  Source
firmware for embedded PowerPC systems.

Hope this helps,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Visit us at Embedded Systems: Feb 14-16 2001, Nuremberg, Halle 12/K01
(with TQ Components); our presentation "Starke Zwerge: Embedded Linux
auf PowerPC-Systemen" on Thursday, Feb 15 2001, 13:30 Forum Halle 11.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
