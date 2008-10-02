Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 9D360DDF31
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 17:34:59 +1000 (EST)
Subject: RE: [PATCH v2] ibm_newemac: Add support for GPCS, SGMII
	andM88E1112 PHY
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Victor Gallardo <vgallardo@amcc.com>
In-Reply-To: <0CA0A16855646F4FA96D25A158E299D602C81377@SDCEXCHANGE01.ad.amcc.com>
References: <1222929477-10329-1-git-send-email-vgallardo@amcc.com>
	<1222929920.12264.96.camel@pasglop>
	<0CA0A16855646F4FA96D25A158E299D602C81377@SDCEXCHANGE01.ad.amcc.com>
Content-Type: text/plain
Date: Thu, 02 Oct 2008 17:32:39 +1000
Message-Id: <1222932759.12264.104.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Jeff Garzik <jgarzik@pobox.com>,
	netdev@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2008-10-02 at 00:30 -0700, Victor Gallardo wrote:
> 
>  
> Yes, this based on Josh's git repository. Should I sync up with your
> git repository or is Josh's OK.

Josh is fine.

Jeff, can we merge all those EMAC patches via the powerpc git ? need an
ack from you I suppose ...

Thanks,
Ben.
