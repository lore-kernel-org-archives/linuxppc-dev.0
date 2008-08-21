Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 05B0ADE44B
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 21 Aug 2008 19:48:46 +1000 (EST)
To: a.schmid@systeme-steuerungen.de
From: Wolfgang Denk <wd@denx.de>
Subject: Re: 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: <FCELKENEBBOLLHKPHCCBEECMCDAA.a.schmid@systeme-steuerungen.de>
References: <FCELKENEBBOLLHKPHCCBEECMCDAA.a.schmid@systeme-steuerungen.de>
Date: Thu, 21 Aug 2008 11:48:43 +0200
Sender: wd@denx.de
Message-Id: <20080821094843.83511243AB@gemini.denx.de>
Cc: linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Dear Alexander,

In message <FCELKENEBBOLLHKPHCCBEECMCDAA.a.schmid@systeme-steuerungen.de> you wrote:
> 
> I use U-Boot 1.2.0 on MPC5200B. Console over serial works fine. I have a

U-Boot related questions are off topic here. Please post such
questions on the U-Boot mailing list, see
http://lists.denx.de/mailman/listinfo/u-boot

Second, U-Boot 1.2.0 is *very* old, please use recent code (1.3.4 or
later).

> Grafic controller at LPB Bus and U-Boot shows his console output at VGa too.
> But I would need a keyboard. I compiled U-Boot with USB and if i type "usb
> reset" the ohci controller scans the USB devices and finds a keyboard. But
> nothing happens if i push the buttons on the keyboard!

There is no USB keyboard driver in U-Boot yet. Please let me know if
you need help to develop one.

Best regards,

Wolfgang Denk

-- 
DENX Software Engineering GmbH,     MD: Wolfgang Denk & Detlev Zundel
HRB 165235 Munich, Office: Kirchenstr.5, D-82194 Groebenzell, Germany
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Time is fluid ... like a river with currents, eddies, backwash.
	-- Spock, "The City on the Edge of Forever", stardate 3134.0
