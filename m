To: Richard Danter <richard.danter@ntlworld.com>
Cc: linuxppc-embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Simple module, but won't build 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 04 May 2004 19:03:22 BST."
             <4097DAEA.5@ntlworld.com>
Date: Tue, 04 May 2004 21:10:05 +0200
Message-Id: <20040504191010.98E50C109F@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <4097DAEA.5@ntlworld.com> you wrote:
>
> When I #include <asm/io.h> I get this error:
>
> /opt/eldk3.0/ppc_82xx/usr/include/asm/io.h: In function `virt_to_bus':
> /opt/eldk3.0/ppc_82xx/usr/include/asm/io.h:235: `CONFIG_KERNEL_START'
> undeclared (first use in this function)
...
> /opt/eldk3.0/ppc_82xx/usr/include/asm/uaccess.h: In function `verify_area':
> /opt/eldk3.0/ppc_82xx/usr/include/asm/uaccess.h:37: `CONFIG_TASK_SIZE'
> undeclared (first use in this function)
...
> I know I have used these with no problems with an older kernel and
> compiler. Is there something I need to add to make these work??

Seems you are missing to include some necessary header  files  and/or
to provide the necessary compiler options.

It's difficult to guess what  exactly  is  missing  given  so  little
information.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
"If you own a machine, you are in turn owned by it,  and  spend  your
time serving it..."    - Marion Zimmer Bradley, _The Forbidden Tower_

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
