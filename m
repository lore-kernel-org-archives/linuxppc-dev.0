Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C2FA3DE286
	for <linuxppc-dev@ozlabs.org>; Sat, 21 Jun 2008 05:50:56 +1000 (EST)
Message-ID: <485C0A16.6040905@freescale.com>
Date: Fri, 20 Jun 2008 14:50:46 -0500
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: John Rigby <jrigby@freescale.com>
Subject: Re: [PATCH 2/2][Rev4] fs_enet: add MPC5121 FEC support
References: <1213802154-28968-1-git-send-email-jrigby@freescale.com>	<1213802154-28968-2-git-send-email-jrigby@freescale.com>
	<1213802154-28968-3-git-send-email-jrigby@freescale.com>
In-Reply-To: <1213802154-28968-3-git-send-email-jrigby@freescale.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Sam Ravnborg <sam@ravnborg.org>, jeff@garzik.org,
	netdev@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

John Rigby wrote:
> +       select PPC_CPM_NEW_BINDING if PPC_MPC512x

Don't bother with this.  It's always selected on arch/powerpc -- and now 
that arch/ppc is gone, there are patches floating around to remove the 
ifdefs.

-Scott
