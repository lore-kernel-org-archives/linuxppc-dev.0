Return-Path: <wd@denx.de>
Received: from mailout06.sul.t-online.com (mailout06.sul.t-online.com
	[194.25.134.19]) by ozlabs.org (Postfix) with ESMTP id DC226685F8
	for <linuxppc-dev@ozlabs.org>; Tue, 25 Oct 2005 04:24:20 +1000 (EST)
To: Kumar Gala <kumar.gala@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Mon, 24 Oct 2005 10:16:21 CDT."
	<989A4B75-70FA-43BE-AAA7-379D42AFEA49@freescale.com>
Date: Mon, 24 Oct 2005 20:23:55 +0200
Sender: wd@denx.de
Message-Id: <20051024182355.7E37E353444@atlas.denx.de>
Cc: linuxppc-dev@ozlabs.org
Subject: Re: [Patch] Add support for TQM834x Boards 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <989A4B75-70FA-43BE-AAA7-379D42AFEA49@freescale.com> you wrote:
> 
> Will you or Marian being maintaining this board family going forward?

I'll be the maintainer / contact.

> Also, you need to split out the MTD portion and submit that to the  
> MTD maintainer separately.

I already did so. Included here for completeness. Let me know if this
is a problem and I will resubmit without the MTD part.

> The only other comment is that tqm834x_show_cpuinfo() might want to  
> be updated the vendor info.

What do you mean? We set vendor as  "Freescale  Inc."  -  isn't  this
correct for the MPC8349 CPU? What schould it be?

> Otherwise, once the I2C DS1337 patch is ack'd I'll push this upstream.

Thanks.

Ummm... what about my earlier patch for the PPChameleonEVB board?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
A committee is a group that keeps the minutes and loses hours.
                                                      -- Milton Berle
