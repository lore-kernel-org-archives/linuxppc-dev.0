To: laurent.pinchart@capflow.com
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: SCC or SMC for console ? 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 15 Feb 2002 15:24:38 +0100."
             <3C6D1A26.1040209@capflow.com>
Date: Fri, 15 Feb 2002 15:35:37 +0100
Message-Id: <20020215143542.4B06510E4C@denx.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <3C6D1A26.1040209@capflow.com> you wrote:
>
> >Should be no problem. The kernel on our FTP server was tested with  6
> >serial  ports  on  a  MPC860, with HW flow controll on all SCC's.
> >
> Reading arch/ppc/8xx_io/uart.c, I found out that all the flow control
> related code was surrounded by false #if #endif. It seems that there is

You're reading the wrong code, it seems.

Get the sources from ftp://ftp.denx.de/pub/LinuxPPC/usr/src/
You will find a lot of CONFIG_UART_CTS_CONTROL_SCCx,
CONFIG_UART_RTS_CONTROL_SCCx, CONFIG_UART_CD_CONTROL_SCCx, and
CONFIG_UART_DTR_CONTROL_SCCx stuff there.

Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
See us @ Embedded Systems Nuremberg, Feb 19-21, Hall 12 K01 (with TQ)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
