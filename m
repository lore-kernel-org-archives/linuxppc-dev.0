To: rekha gvv <rekhagvvc@yahoo.co.in>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Combine kernel and ramdisk image. 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 10 Feb 2003 22:49:11 PST."
             <20030211064911.50039.qmail@web8007.mail.in.yahoo.com>
Date: Tue, 11 Feb 2003 09:03:40 +0100
Message-Id: <20030211080345.C9EDEC6096@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <20030211064911.50039.qmail@web8007.mail.in.yahoo.com> you wrote:
>
> PMulti is the Combined kernal image ..
> wheni download it to the powerpc board using ppcboot I
> get this .
>
> bootm
> ## Booting image at 00100000 ...

----------------------^^^^^^^^

Your load address is too low. You will overwrite the  image  contents
while it's uncompressing.

...
>    Loading Ramdisk to 6fabe000, end 0075a4bc ...

This is why you see garbage here.

> what could be the error....

Chose a higher load address, something like "bootm 400000".



And again, this is basicly off topic here.


Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Anyone who doesn't believe in miracles is not a realist.
                                                   - David Ben Gurion

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
