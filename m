To: "Yang, Bo" <bo.yang@transcore.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Kernel Debugging 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 15 Apr 2003 09:01:20 MDT."
             <406B9D084FAFD4118C980008C79FADB901B57FF9@ALBMAIL>
Date: Tue, 15 Apr 2003 17:38:02 +0200
Message-Id: <20030415153807.E9688C58B9@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Bo Yang,

in message <406B9D084FAFD4118C980008C79FADB901B57FF9@ALBMAIL> you wrote:
>
> Thank you for your prompt reply.

You are welcome.

> Could you please tell me where I can get or how to build a PPC cross version
> of GDB.

You can download the latest  version  of  our  ELDK  (Embedded  Linux
Development  Kit)  from ftp://ftp.leo.org/pub/eldk/2.1.0/, please see
ftp://ftp.leo.org/pub/eldk/2.1.0/eldk-ppc-linux-x86/README.html    or
http:www.denx.de/re/ELDK.html for detailed instructions.

> Also, I have following questions I can't find the answer:
> Is it enough just to include kgdb support when configuring kernel to build
> linux kernel with kgdb support?
> Has DENX's linux-2.4.4 kernel been patched with kgdb already or not?

Actually, we don't use kgdb. We  use  the  Abatron  BDI2000  for  all
kernel and device driver debugging (on PPC, ARM, and MIPS).

> Are the ? marks shown on serial console when kernel built with kgdb support
> starts run supposed to see or some else?

kgdb  will  stop  at  a  built-in  breakpoint  pretty  early  in  the
initialization  sequence  to  allow  you  to set more breakpoints for
example to debug drivers etc. It expects  that  you  connect  with  a
debugger on the serial line.

Best regards,

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Systems programmers are the high priests of a low cult.
                                                       -- R.S. Barton

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
