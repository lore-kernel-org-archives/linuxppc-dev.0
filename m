Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 31D2A2BDA3
	for <linuxppc-dev@ozlabs.org>; Sat, 25 Sep 2004 03:22:07 +1000 (EST)
To: Jeff Angielski <jeff@theptrgroup.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 24 Sep 2004 09:55:25 EDT."
	<1096034125.8121.15.camel@nighteyes.localdomain>
Date: Fri, 24 Sep 2004 19:21:51 +0200
Sender: wd@denx.de
Message-Id: <20040924172156.0B4A9C108D@atlas.denx.de>
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: MPC8260 SCC2 UART hang 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <1096034125.8121.15.camel@nighteyes.localdomain> you wrote:
> 
> I am having a problem with the SCC2 uart whereby the system hangs
> whenever I try to use that device.  It happens using both the Denx
> kernel and the kernel.org 2.4.27 kernel.
> 
> I was hoping that somebody can tell me if SCC2 works as expected on
> their MPC8260 hardware so that I can reduce the scope of my debug
> effort.

Our kernel tree has been tested and works fine  for  example  on  the
PM826 board.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-4596-87  Fax: (+49)-8142-4596-88  Email: wd@denx.de
You don't need a weatherman to know which way the wind blows.
                                                          - Bob Dylan
