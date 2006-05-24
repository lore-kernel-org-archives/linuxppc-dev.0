Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 023FD67A3A
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 05:57:49 +1000 (EST)
To: jourdan@enib.fr
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Can't get CoralP drivers to work 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Wed, 24 May 2006 18:54:00 +0200."
	<3799.194.3.133.184.1148489640.squirrel@webmail.enib.fr>
Date: Wed, 24 May 2006 21:57:47 +0200
Sender: wd@denx.de
Message-Id: <20060524195747.0CE6E353BFD@atlas.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <3799.194.3.133.184.1148489640.squirrel@webmail.enib.fr> you wrote:
> 
> I have a MPC8260 processor card with a Coral-P evaluation board (rev 4.0).
> My system do not have keyboard nor mouse (i use the serial console).
> 
> I use linux kernel 2.4.25 & 2.6.9.

We have instructions on our web site; did you read these?

> I'm trying to get the framebuffer driver to work. During the boot the
> driver loads fine but the monitor remains blank (no video signal). If i
> try to `cat /dev/urandom > /dev/fb/0` nothing happens.

Are you using devfs? Don't! Use /dev/fb0

> I compiled an Xserver (Release 6.9), and the x11 drivers for the coralp.
> When I start X, it says that it can not open tty0 (indeed it doesn't
> exists).

Well, you got an error message (tty0 cannot be opened), you  verified
that it is valid (tty0 does not exist), so fix the problem...

> For kernel 2.6.9 :

Can't comment on Coreal-P on 2.6.x

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
War is never imperative.
	-- McCoy, "Balance of Terror", stardate 1709.2
