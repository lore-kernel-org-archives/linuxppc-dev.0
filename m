To: Jeff Tucker <jeff@jltnet.com>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Need help booting linux on IBM 405EP eval board 
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 04 Apr 2004 18:37:03 EDT."
             <72099343.1081103823@[192.168.2.18]>
Date: Mon, 05 Apr 2004 01:13:13 +0200
Message-Id: <20040404231318.68E6FC109A@atlas.denx.de>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


In message <72099343.1081103823@[192.168.2.18]> you wrote:
>
> The exact same kernel boots with the IBM bootloader, including serial
> console and network access. When I boot using U-Boot, I don't get a console
> and there's no apparent network activity from the board.

How about the log_buf contents?

And did you try attaching a debugger?


Wolfgang Denk

--
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
A quarrel is quickly settled when deserted by one party; there is  no
battle unless there be two.                                  - Seneca

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
