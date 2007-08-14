Return-Path: <becky.bruce@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id C2CF8DDEDE
	for <linuxppc-dev@ozlabs.org>; Wed, 15 Aug 2007 04:08:48 +1000 (EST)
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0BA10F2B-06FE-411A-9E46-BE1623715A23@freescale.com>
From: Becky Bruce <becky.bruce@freescale.com>
Subject: ft_ordered removal  patch status?
Date: Tue, 14 Aug 2007 13:08:49 -0500
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi Paul,

Is there a reason this hasn't been picked up:

http://ozlabs.org/pipermail/linuxppc-dev/2007-May/035906.html

It fixes a build warning in the tree and removes some dead code. It  
appears to still apply cleanly to the top of your tree.... if there  
are issues please let me know so I can fix them.

Thanks,
Becky
