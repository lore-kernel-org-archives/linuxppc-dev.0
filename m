Return-Path: <wd@denx.de>
Received: from mailout01.sul.t-online.com (mailout01.sul.t-online.com
	[194.25.134.80]) by ozlabs.org (Postfix) with ESMTP id 66B2B68641
	for <linuxppc-dev@ozlabs.org>; Mon, 31 Oct 2005 02:19:02 +1100 (EST)
To: Matthew McClintock <msm@freescale.com>
From: Wolfgang Denk <wd@denx.de>
Mime-version: 1.0
Content-type: text/plain; charset=ISO-8859-1
In-reply-to: Your message of "Sat, 29 Oct 2005 19:38:27 CDT."
	<1130632707.7470.16.camel@localhost.localdomain>
Date: Sun, 30 Oct 2005 16:18:47 +0100
Sender: wd@denx.de
Message-Id: <20051030151847.C4383353416@atlas.denx.de>
Cc: Jeff Garzik <jgarzik@pobox.com>, linuxppc-dev@ozlabs.org
Subject: Re: use of phy_connect() in drivers/net/gianfar.c ? 
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Dear Matthew,

in message <1130632707.7470.16.camel@localhost.localdomain> you wrote:
> 
> As far as I understand there are patches in the -mm tree with contain
> the updates for the Gianfar driver. The issue is due to a

Do you happen to know of a specific (set of) patch(es)? URL?

> synchronization issue with the new PHY abstraction layer that was added.

Yes, obviously. But I am still so naïve to expect that  such  changes
would not make it untested (the code is not even compile clean) to an
official kernel release like 2.6.14 ?

> I know Andy will not be back at his computer until Monday, you can wait
> until then or look for the patch in the -mm tree.

Is there a git repository somewhere for the mm tree?

Best regards,

Wolfgang Denk

-- 
Software Engineering:  Embedded and Realtime Systems,  Embedded Linux
Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de
(null cookie; hope that's ok)
