Return-Path: <glppe-linuxppc-embedded-2@m.gmane.org>
Received: from ciao.gmane.org (main.gmane.org [80.91.229.2])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4AD07DE068
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 22 Apr 2008 01:00:24 +1000 (EST)
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JnxV8-0000mR-7i
	for linuxppc-embedded@ozlabs.org; Mon, 21 Apr 2008 15:00:14 +0000
Received: from p5497c4d8.dip.t-dialin.net ([84.151.196.216])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Apr 2008 15:00:14 +0000
Received: from dzu by p5497c4d8.dip.t-dialin.net with local (Gmexim 0.1
	(Debian)) id 1AlnuQ-0007hv-00
	for <linuxppc-embedded@ozlabs.org>; Mon, 21 Apr 2008 15:00:14 +0000
To: linuxppc-embedded@ozlabs.org
From: Detlev Zundel <dzu@denx.de>
Subject: Re: eldk and usb to serial converters
Date: Mon, 21 Apr 2008 16:59:25 +0200
Message-ID: <m2r6cz45ki.fsf@ohwell.denx.de>
References: <27dfa3d0804171704j711aad1cwe7b558c077da3350@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: news <news@ger.gmane.org>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Hi Daniel,

> I'm currently trying to compile a kernel for an AMCC440EP board within an eldk
> environment. We've got a FTDI usb2serial converter we need to connect to the
> board. Now I've compiled a kernel on a gentoo machine for this device and had
> no problems. With this board, the kernel recognizes the device fine:
>
> ftdi_sio 1-1:1.0: FTDI USB Serial Device converter detected
> usb 1-1: FTDI USB Serial Device converter now attached to ttyUSB0
> drivers/usb/serial/ftdi_sio.c: v1.4.3:USB FTDI Serial Converters Driver
>
> but udev doesn't actually make the ttyUSB0 node. If anyone knows what may have
> caused the problem and how to fix it, it'd be much appreciated.

Maybe udev isn't running at all?  The ELDKs including udev disable it
per default (what version are you using?).  Embedded systeme like to
have static kernel configurations presenting no surprises at runtime...

Cheers
  Detlev

-- 
Programming X-Windows is like trying to find the square root of pi
using roman numerals.
                                          -- The UNIX Haters Handbook
--
DENX Software Engineering GmbH,      MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich,  Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-40 Fax: (+49)-8142-66989-80 Email: dzu@denx.de
