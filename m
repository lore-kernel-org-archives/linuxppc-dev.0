To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC or SMC for console ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Thu, 14 Feb 2002 18:28:17 +0100."
             <3C6BF3B1.2040906@capflow.com>
Date: Thu, 14 Feb 2002 19:31:58 +0100
Message-Id: <20020214183203.C4651109E2@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Dear Laurent,

in message <3C6BF3B1.2040906@capflow.com> you wrote:
>
> I need 4 serial ports at runtime, and was wondering if I should rather
> use 2SMC + 2SCC or 4 SCC (or 1SMC + 3SCC).

Assuming that you need Ethernet: if you can use the FEC for Ethernet,
that it does not matter much; otherwise I'd recommend to use  2SMC  +
2SCC  or  1SMC  +  3SCC  so  that  you  have at east one SCC left for
Ethernet.

> I need a console, but no hardware flow control (which would force the
> use of SCC).

Should be no problem. The kernel on our FTP server was tested with  6
serial  ports  on  a  MPC860, with HW flow controll on all SCC's. The
only problem in such a configuration is that you have only 4 BRG's so
two ports have to share the baudrate with another port.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
