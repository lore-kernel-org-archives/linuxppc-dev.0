Return-Path: <jourdan@enib.fr>
Received: from alto.enib.fr (alto.enib.fr [195.221.233.5])
	by ozlabs.org (Postfix) with ESMTP id ED85F67B2E
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 25 May 2006 03:15:38 +1000 (EST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by alto.enib.fr (Postfix) with ESMTP id AC4F0EF1EE
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 18:54:00 +0200 (CEST)
Received: from alto.enib.fr ([127.0.0.1])
	by localhost (alto.enib.fr [127.0.0.1]) (amavisd-new,
	port 10024) with ESMTP
	id 27386-06 for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 18:54:00 +0200 (CEST)
Received: from webmail.enib.fr (localhost.localdomain [127.0.0.1])
	by alto.enib.fr (Postfix) with ESMTP id 8F777EF17F
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 24 May 2006 18:54:00 +0200 (CEST)
Message-ID: <3799.194.3.133.184.1148489640.squirrel@webmail.enib.fr>
Date: Wed, 24 May 2006 18:54:00 +0200 (CEST)
Subject: Can't get CoralP drivers to work
From: jourdan@enib.fr
To: linuxppc-embedded@ozlabs.org
MIME-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hello

I have a MPC8260 processor card with a Coral-P evaluation board (rev 4.0).
My system do not have keyboard nor mouse (i use the serial console).

I use linux kernel 2.4.25 & 2.6.9.

For kernel 2.4.25 :

I'm trying to get the framebuffer driver to work. During the boot the
driver loads fine but the monitor remains blank (no video signal). If i
try to `cat /dev/urandom > /dev/fb/0` nothing happens.

I compiled an Xserver (Release 6.9), and the x11 drivers for the coralp.
When I start X, it says that it can not open tty0 (indeed it doesn't
exists).

For kernel 2.6.9 :

When I start X, it complains about virtual terminals but doesn't stop. It
loads the x11_mb86290 driver then stop because it can't find a valid
framebuffer driver. Is it mandatory to have the mb86290fb driver worknig
in order to get the x11_mb86290 driver ?

I guess it just a configuration problem but I can figure it out. I added
the support for virtual terminals in my kernel (X seems to need it) but I
don't have ttyN entries in /dev. If I add them manually, they can not be
opened.

Thanks for your help.
