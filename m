Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 5C25367B34
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  7 Mar 2006 09:29:04 +1100 (EST)
To: John Otken <jotken@softadvances.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: make modules_install fails with [_modinst_post] Error 139 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 06 Mar 2006 14:42:19 CST."
	<440C9EAB.7080504@softadvances.com>
Date: Mon, 06 Mar 2006 23:29:02 +0100
Sender: wd@denx.de
Message-Id: <20060306222902.7ACDD3535F7@atlas.denx.de>
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

Dear John,

in message <440C9EAB.7080504@softadvances.com> you wrote:
>
> I want to simulate an USB thumb drive using the Yosemite's device
> interface.  So the Yosemite board is the thumb drive.  I am not trying
> to connect a thumb drive to the Yosemite.  Sorry if I wasn't clear.

I see.

> > Your native system's (x86 ?) module utilities (depmod,  modprobe)  do
> > not understand PowerPC modules. If you want to run "depmod", you must
> > overwrite  the  Makefile's  default  setting of DEPMOD to use a cross
> > version of depmod instead.
> 
> Thanks, I'll work on that.

Try Busybox' depmod.pl script ...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Overdrawn?  But I still have checks left!
