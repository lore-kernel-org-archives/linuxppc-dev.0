To: Wojciech Kromer <krom@dgt-lab.com.pl>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: linux-2.4.18 & copy-back cache mode 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 08 Mar 2002 15:41:54 +0100."
             <3C88CDB2.7070905@dgt-lab.com.pl>
Date: Fri, 08 Mar 2002 16:22:44 +0100
Message-Id: <20020308152249.B9AC9109EF@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C88CDB2.7070905@dgt-lab.com.pl> you wrote:
>
> Anyone could send me UPM table for CAS_LATENCY==3. I'm not sure if burst is realy needed. Now its disabled, because I do not have correct UPM table for this.

Browse the PPCBoot sources;  I  added  a  configuration  for  TQM8xxL
modules   at   66   MHz  (cpu-bus  1:1)  recently;  also,  the  LWMON
configuration runs at 66 MHz 1:1.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
Every time history repeats itself the price goes up.

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
