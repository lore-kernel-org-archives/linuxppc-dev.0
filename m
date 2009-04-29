Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 442FADDE22
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Apr 2009 07:47:42 +1000 (EST)
Message-Id: <CC38704C-04FB-4057-A801-C4642A92CA19@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Feng Kan <fkan@amcc.com>
In-Reply-To: <1241041345-19479-1-git-send-email-fkan@amcc.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH 1/2] Add support for Designware SATA controller driver
Date: Wed, 29 Apr 2009 16:47:32 -0500
References: <1241041345-19479-1-git-send-email-fkan@amcc.com>
Cc: linuxppc-dev@ozlabs.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 29, 2009, at 4:42 PM, Feng Kan wrote:

> Signed-off-by: Feng Kan <fkan@amcc.com>
> ---
> drivers/ata/Kconfig    |   76 +-
> drivers/ata/Makefile   |    1 +
> drivers/ata/sata_dwc.c | 2047 +++++++++++++++++++++++++++++++++++++++ 
> +++++++++
> 3 files changed, 2091 insertions(+), 33 deletions(-)
> create mode 100644 drivers/ata/sata_dwc.c

you should copy Jeff & linux-ide@vger.kernel.org on SATA drivers.

- k
