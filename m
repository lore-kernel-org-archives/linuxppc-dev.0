To: g.ramakrishna@exgate.tek.com
Cc: linuxppc-embedded@lists.linuxppc.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Can not boot linux-2.4.4 using ppcboot-1.0.4 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 21 Sep 2001 01:30:15 PDT."
             <301A812E6528D511A8F70008C71E578616C92E@AP-BANG-M02>
Date: Sun, 23 Sep 2001 20:00:27 +0200
Message-Id: <20010923180032.CA7D81009E@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <301A812E6528D511A8F70008C71E578616C92E@AP-BANG-M02> you wrote:
>
> I am trying to boot Linux-2.4.4 kernel using ppcboot-1.0.4.
> It hangs after printing "## Transferring control to Linux (at address
> 00000000) ..."

This is a FAQ. See the PPCBoot mailing list archive.

The usual reason is that you missed to adapt your board  header  file
used  in  the  LInux  kernel  to  match the definition of the bd_info
structure as passed by PPCBoot. Usually  you  can  just  delete  this
definition  from  your  board header file and include <asm/ppcboot.h>
instead.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
I'd rather be led to hell than managed to heaven.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
