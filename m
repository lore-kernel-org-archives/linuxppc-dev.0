Return-Path: <msm@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id A43796862A
	for <linuxppc-dev@ozlabs.org>; Sun, 30 Oct 2005 11:38:50 +1100 (EST)
Received: from de01smr01.am.mot.com (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	j9U1luML006356
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 19:47:56 -0600 (MDT)
Received: from az33exm43.am.freescale.net (az33exm43.am.freescale.net
	[10.64.34.249])
	by de01smr01.am.mot.com (8.13.1/8.13.0) with ESMTP id j9U0ltUc015756
	for <linuxppc-dev@ozlabs.org>; Sat, 29 Oct 2005 19:47:55 -0500 (CDT)
From: Matthew McClintock <msm@freescale.com>
To: Wolfgang Denk <wd@denx.de>
In-Reply-To: <20051029204032.BA111353A42@atlas.denx.de>
References: <20051029204032.BA111353A42@atlas.denx.de>
Content-Type: text/plain
Date: Sat, 29 Oct 2005 19:38:27 -0500
Message-Id: <1130632707.7470.16.camel@localhost.localdomain>
Mime-Version: 1.0
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

Hello Wolfgang,

As far as I understand there are patches in the -mm tree with contain
the updates for the Gianfar driver. The issue is due to a
synchronization issue with the new PHY abstraction layer that was added.
I know Andy will not be back at his computer until Monday, you can wait
until then or look for the patch in the -mm tree.

Regards,
Matthew

On Sat, 2005-10-29 at 13:40 -0700, Wolfgang Denk wrote:
> Hello,
> 
> this commit in the 2.6.14 tree is breaking drivers/net/gianfar.c  for 
> me:
> 
>         Commit: bb40dcbb0fcebe1df08ba261483fcc38b307d063 
>         Author: Andy Fleming <afleming@freescale.com>  2005-09-24
> 04:54:21 
>         Committer: Jeff Garzik <jgarzik@pobox.com>  2005-09-24
> 04:54:21 
>         Parent: acc4b985a6f8f22a0e826692894a4af234764001 ([PATCH]
> orinoco: Bump version to 0.15rc3.) 
>         Child:  8cee0cd5bec53b78dd3c43a73b27821a688133e6 ([netdrvr]
> delete CONFIG_PHYCONTROL)
> 
>             [netdrvr gianfar] use new phy layer 
>                  
>             Signed-off-by: Andy Fleming <afleming@freescale.com> 
>             Signed-off-by: Jeff Garzik <jgarzik@pobox.com>
> 
> I get:
> 
> drivers/net/gianfar.c: In function `init_phy': 
> drivers/net/gianfar.c:410: error: structure has no member named
> `bus_id'
> 
> 
> Am I missing something?
> 
> Best regards,
> 
> Wolfgang Denk
> 
> --  
> Software Engineering:  Embedded and Realtime Systems,  Embedded Linux 
> Phone: (+49)-8142-66989-10 Fax: (+49)-8142-66989-80 Email: wd@denx.de 
> In C we had to code our own bugs, in C++ we can inherit them. 
> _______________________________________________ 
> Linuxppc-dev mailing list 
> Linuxppc-dev@ozlabs.org 
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
