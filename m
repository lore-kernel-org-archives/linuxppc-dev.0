To: "Ing.Gianfranco Morandi (LAN)" <gianfranco.morandi@euro-studio.it>
Cc: "LinuxPPC" <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: "mkimage" not found 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 05 Mar 2004 10:10:53 +0100."
             <00a101c40291$c31a7120$0400a8c0@portatile>
Date: Fri, 05 Mar 2004 10:19:36 +0100
Message-Id: <20040305091941.73A3AC0655@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Gianfranco,

in message <00a101c40291$c31a7120$0400a8c0@portatile> you wrote:
>
> > Maybe your PATH ist not correct?
>
> You are perfectly right! I didn't add the line "export

Thanks for the confirmation.

> [gianfranco@home001 linux]$ make pImage
> make: *** No rule to make target `pImage'.  Stop.
...
> Should I modify BOOT_TARGET into arch/ppc/Makefile?

As you like. Maybe it's better to get used to the U-Boot image name.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
There is is no reason for any individual to have a computer in  their
home.      -- Ken Olsen (President of Digital Equipment Corporation),
              Convention of the World Future Society, in Boston, 1977

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
