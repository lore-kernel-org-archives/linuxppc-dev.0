Return-Path: <wd@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id 8067F679EA
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Apr 2006 09:07:23 +1000 (EST)
To: Tom Rini <trini@kernel.crashing.org>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: FT u-boot shim 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 28 Apr 2006 12:44:57 PDT."
	<20060428194457.GA458@smtp.west.cox.net>
Date: Sat, 29 Apr 2006 01:07:20 +0200
Sender: wd@denx.de
Message-Id: <20060428230720.7C0CB353DAC@atlas.denx.de>
Cc: "linuxppc-dev@ozlabs.org list" <linuxppc-dev@ozlabs.org>,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Tom,

in message <20060428194457.GA458@smtp.west.cox.net> you wrote:
>
> > > 3. using a u-boot that is ft aware + built in dtb.
...
> > Assuming we had 2., under which circumstances would we need 3. then?
> 
> Especially if we had mkuimage let you tack your dtb into the 'kernel'
> image.

Sorry, but I don't understand. If we have the dtb combined  with  the
kernel  image,  then  why would we need another copy of the dtb built
into U-Boot?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A day without sunshine is like night.
