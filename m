To: "Stephen Williams" <612dlag102@sneakemail.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel hangs in early_init 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 01 Mar 2004 22:41:34 PST."
             <19122-27221@sneakemail.com>
Date: Tue, 02 Mar 2004 09:51:53 +0100
Message-Id: <20040302085159.1174CC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <19122-27221@sneakemail.com> you wrote:
>
> I have a PPC405GPr based board w/ 128Meg SDRAM, and I'm building
> kernel 2.4.24 (devel CVS) for it. I also have U-Boot ported to
> it, and I'm using U-Boot as the bootstrap loader.
...
> ## Transferring control to Linux (at address 00000000) ...

Did you check the FAQ? See
http://www.denx.de/twiki/bin/view/DULG/LinuxHangsAfterUncompressingKernel

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
The only way to get rid of a temptation is to yield to it.
                                                        - Oscar Wilde

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
