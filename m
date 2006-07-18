Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id BB91D67B85
	for <linuxppc-dev@ozlabs.org>; Wed, 19 Jul 2006 02:11:33 +1000 (EST)
To: Kumar Gala <galak@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [PATCH] Add USB to MPC8349 PB platform support 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Tue, 18 Jul 2006 08:52:31 CDT."
	<41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org>
Date: Tue, 18 Jul 2006 17:53:26 +0200
Sender: wd@denx.de
Message-Id: <20060718155326.41B8B353AD2@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org, linux-usb-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <41AD230F-91E8-442A-B9F9-9892D14BEF12@kernel.crashing.org> you wrote:
> 
> I'm talking about opening the door to a ton of options, not that we  
> have them now.  For example, your patch doesnt handle the USB PHYs if  

If you really assume that all this has  to  be  handled  in  so  many
configuration  options  then it probably makes not much difference if
you do this in the kernel  or  in  any  boot  loader  -  you're  just
shifting  effort  and  responsibility  to somebody else. I agree with
Dan's argumentation.

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
Chapter 1 -- The story so  far:
In the beginning the Universe was created. This has  made  a  lot  of
people very angry and been widely regarded as a bad move.
