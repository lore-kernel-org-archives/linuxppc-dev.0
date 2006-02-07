Return-Path: <bunk@stusta.de>
Received: from mailout.stusta.mhn.de (mailout.stusta.mhn.de [141.84.69.5])
	by ozlabs.org (Postfix) with SMTP id B9219689DD
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Feb 2006 09:14:52 +1100 (EST)
Date: Tue, 7 Feb 2006 23:14:49 +0100
From: Adrian Bunk <bunk@stusta.de>
To: ebs@ebshome.net
Subject: IBM_EMAC_PHY_RX_CLK_FIX depends on non-existing option 440GR
Message-ID: <20060207221449.GB3524@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, Jean-Luc Leger <reiga@dspnet.fr.eu.org>,
	linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jean-Luc Leger <reiga@dspnet.fr.eu.org> reported the following:

from drivers/net/Kconfig:
config IBM_EMAC_PHY_RX_CLK_FIX
        bool "PHY Rx clock workaround"
        depends on IBM_EMAC && (405EP || 440GX || 440EP || 440GR)
-> maybe this is 440GP ?


The non-existing CONFIG_440GR is also present in the driver itself.

Is this a typo or a not yet merged platform?

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed
