Return-Path: <vitb@kernel.crashing.org>
Received: from localhost.localdomain (unknown [85.94.3.83])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 3AC04DDEE3
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 11:26:27 +1000 (EST)
From: Vitaly Bordug <vitb@kernel.crashing.org>
To: linux-pcmcia@lists.infradead.org
Subject: [PATCH 0/2] of_device 8xx PCMCIA support && cleanup
Date: Sun, 06 May 2007 05:26:08 +0400
Message-ID: <20070506011004.12695.41514.stgit@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Current series features the reworked  8xx of_device PCMCIA patch
based on feedback from Andrew + indentation & whitespace fixes
in drivers/pcmcia/m8xx_pcmcia.c

Andrew,
Please disregard previous patch since it contains a typo. Indentation 
patch is not strictly necessary but is useful too, imho.

--
-Vitaly
