To: "Billalabeitia, Jose Carlos (IndSys,     GEPM)" <jc.billalabeitia@indsys.ge.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: sh: tcsetpgrp: Inappropriate ioctl for device 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 11 Jul 2002 09:18:20 EDT."
             <A1C99F4731CAD111BA5400A024FC3B0CCD0938@ESBILMA01EDCGE>
Date: Thu, 11 Jul 2002 15:38:34 +0200
Message-Id: <20020711133839.311E010870@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello,

in message <A1C99F4731CAD111BA5400A024FC3B0CCD0938@ESBILMA01EDCGE> you wrote:
>
> 	I have a custom board with kernel 2-4-4-2002-02-14 from
> denx and busybox 0.51. Every time an script is executed in
> the console I get the message:
>
> 	"sh: tcsetpgrp: Inappropriate ioctl for device"
>
> It doesn´t happen when the script is executed from a telnet
> session. This is not harmful for the script but it´s very annoying.
> Can anyone out there tell me how I can eliminate this message.

Use a more recent version of busybox.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Monday is an awful way to spend one seventh of your life.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
