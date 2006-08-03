Return-Path: <wd@denx.de>
To: "Li Yang" <LeoLi@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Subject: Re: [RFC] New target 'cuImage' - compatibility uImage 
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Fri, 04 Aug 2006 00:17:53 +0800."
	<a0bc9bf80608030917y7fde2b75n6719dc675cad8cfe@mail.gmail.com>
Date: Thu, 03 Aug 2006 22:07:53 +0200
Sender: wd@denx.de
Message-Id: <20060803200753.08F49353C18@atlas.denx.de>
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <a0bc9bf80608030917y7fde2b75n6719dc675cad8cfe@mail.gmail.com> you wrote:
>
> Though it will need more space, the increase won't be too much as
> wrapper and FDT should be very small.  The benefit is that kernel can
> be extract directly to it's destination(address 0), rather than
> extract to another place and then move it there.  A classical
> time/space tradeoff.

You probably cannot expect a perfect solution when  retrofitting  new
features  into  an  old  system  (this  we should keep in mind: we're
talking about old U-Boot versions only, not  about  current  versions
which will support DT).


BTW: Another option is using U-Boot's multifile image format...

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
That said, there may be good reasons for what you did beyond obsequi-
ous sycophantic parody. Perhaps you might be so kind as to elucidate.
         -- Tom Christiansen in <5ldjbm$jtk$1@csnews.cs.colorado.edu>
