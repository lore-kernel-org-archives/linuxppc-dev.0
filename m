Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A6436DE153
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Jan 2009 14:17:46 +1100 (EST)
Subject: RE: [PATCH] ibm_newemac: Add support for Arches CPU0 SGMII0 to
	CPU1SGMII0
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Gallardo <vgallardo@amcc.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D605B6134D@SDCEXCHANGE01.ad.amcc.com>
References: <0CA0A16855646F4FA96D25A158E299D60546CA64@SDCEXCHANGE01.ad.amcc.com>
	<0CA0A16855646F4FA96D25A158E299D605505DDC@SDCEXCHANGE01.ad.amcc.com>
	<0CA0A16855646F4FA96D25A158E299D605B6134D@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Sat, 17 Jan 2009 14:16:26 +1100
Message-Id: <1232162186.23611.19.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Fri, 2009-01-16 at 16:14 -0800, Victor Gallardo wrote:
> Hi Josh,
> 
> I see you are delegated for this patch submission any ideas when it will be accepted.
> 
> http://patchwork.ozlabs.org/patch/6814/

Looks like it fell through the cracks.

Can you resend it to both our list and netdev@vger.kernel.org ? Keep
CC'me, I'll ack it and then it will be up to the networking folks to
pick it up.

Cheers,
Ben.
