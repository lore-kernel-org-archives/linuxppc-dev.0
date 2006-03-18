Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 22569679F4
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 18 Mar 2006 11:21:16 +1100 (EST)
To: jimmy liu <jimmyzhmliu@yahoo.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: Linux kernel reboot issue 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 17 Mar 2006 07:35:50 PST."
	<20060317153550.19366.qmail@web53111.mail.yahoo.com>
Date: Sat, 18 Mar 2006 01:21:13 +0100
Sender: wd@denx.de
Message-Id: <20060318002114.07E473535F7@atlas.denx.de>
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

In message <20060317153550.19366.qmail@web53111.mail.yahoo.com> you wrote:
> Our custom board is similar as EST8260. We use Linux
> Kernel 2.4.25 from ftp://ftp.denx.de/pub/linux/. When
> we type the reboot command or shutdown -r, we got the
> following error messages. Does anybody has idea? 

Your board may be similar, but it is obviously not identical  to  the
EST8260.  You  must  port  Linux  to your hardware, not just use some
"similar" board configuration.


Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
The idea of male and female are universal constants.
	-- Kirk, "Metamorphosis", stardate 3219.8
