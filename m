Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 6A4276890B
	for <linuxppc-embedded@ozlabs.org>;
	Fri,  6 Jan 2006 21:13:27 +1100 (EST)
To: zengshuai@sogou.com
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 06 Jan 2006 16:49:50 +0800."
	<23894955.1136537390660.JavaMail.postfix@mx3.mail.sohu.com>
Date: Fri, 06 Jan 2006 11:13:25 +0100
Sender: wd@denx.de
Message-Id: <20060106101325.B9FED354113@atlas.denx.de>
Cc: ppc <linuxppc-embedded@ozlabs.org>
Subject: Re: Help need: Porting Linux to PQ2FADS_ZU board 
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

In message <23894955.1136537390660.JavaMail.postfix@mx3.mail.sohu.com> you wrote:
>
> My board is PQ2FADS_ZU.Does the ELDK not support it?

ELDK is, as the  name  suggests,  a  Development  Toolkit,  i.  e.  a
toolchain. As such, it is independent from the hardware and doesn not
support  any specific board, or, if you like, it supports all boards,
even those that don't exist yet.

What you are asking for is board support in a specific  kernel  tree.
There  is  no  specific  support  for  the  PQ2FADS_ZU  board  in our
linuxppc_2_4_devel  tree   (which   is   included   with   the   ELDK
distribution). On the other hand this is a standard board which which
is probably working fine, but we never tested or varified it.

I guess that it is not configured for use with U-Boot.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
"Never give in.  Never give in.  Never. Never. Never."
- Winston Churchill
