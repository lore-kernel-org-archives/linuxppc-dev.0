Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 78F8C67CD5
	for <linuxppc-embedded@ozlabs.org>;
	Mon,  6 Nov 2006 08:48:27 +1100 (EST)
To: linuxppc-embedded@ozlabs.org
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Has anyone 2.6 kernel with Xenomai and MPC5200 Lite running? 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sun, 05 Nov 2006 21:23:36 +0100."
	<20061105202336.GA30026@server.idefix.loc>
Date: Sun, 05 Nov 2006 22:48:24 +0100
Sender: wd@denx.de
Message-Id: <20061105214824.8FD44353A5F@atlas.denx.de>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <20061105202336.GA30026@server.idefix.loc> you wrote:
> 
> how can I checkout kernel 2.6.18 with denx improvements?

run gitk and check where our tree was megred with the Linus tree after
the v2.6.18 release - you will find that it's commit ID
dee0eedc749e35f85103f33d9c28bdfcdc1a8fb4

> I need the system only for development, the targetsystem will run on
> another board :)

I'm not talking about a specific board, but about MPC5200 in general.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
About the use of language: it is impossible to sharpen a pencil  with
a  blunt  ax.  It is equally vain to try to do it with ten blunt axes
instead.                                           -- Edsger Dijkstra
