To: "Aman" <aman@mistralsoftware.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Linux Image 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 20 Aug 2002 06:06:55 +0530."
             <001701c247e1$af6bb380$370da8c0@aman>
Date: Thu, 17 Oct 2002 18:40:21 +0200
Message-Id: <20021017164026.4E674FAA7@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <001701c247e1$af6bb380$370da8c0@aman> you wrote:
>
> I have an rom monitor code without ethernet support running on PPC440GP. Is

Install PPCBoot.

> it possible to download a linux image to the board using the Kermit
> protocol. If so what type of linux image has to build for that.

Yes, this is possible. PPCBoot supports kermit binary  protocol  (use
the  "loadb" command). Umm... but PPCBoot also supports download over
ethernet, so you probably will not use "loadb".

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Testing can show the presense of bugs, but not their absence.
                                                   -- Edsger Dijkstra

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
