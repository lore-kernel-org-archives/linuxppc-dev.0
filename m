To: "Jack Liu" <Jack_liu@usish.com>
Cc: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Sandpoint problems 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 16 Feb 2004 18:59:34 +0800."
             <200402161059.i1GAxDqA002613@ms.usish.com>
Date: Mon, 16 Feb 2004 12:04:24 +0100
Message-Id: <20040216110429.9A721C1096@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <200402161059.i1GAxDqA002613@ms.usish.com> you wrote:
>
>  I used u_boot.srec. To program flash, it will first be converted to binary file.

Why not using u-boot.bin directly, then?

> >shouting?) Is the board completely dead? Is there Some output? Which?
> >Does U-Boot run, but fails to boot Linux? Or what?
>     PCI LED on the board is active continuously.Yet no output. u-boot can not boot. Did I miss anything?

attach a debugger.

And please let's continue this thread on u-boot-users.

Best regards,

Wolfgang Denk

--
See us @ Embedded World, Nuremberg, Feb 17 - 19,  Hall 12.0 Booth 440
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Where there's no emotion, there's no motive for violence.
	-- Spock, "Dagger of the Mind", stardate 2715.1

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
