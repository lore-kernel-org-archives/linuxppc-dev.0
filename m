Return-Path: <sr@denx.de>
Received: from mo-p05-ob6.rzone.de (mo-p05-ob6.rzone.de
 [IPv6:2a01:238:20a:202:53f5::1])
 (using TLSv1 with cipher EDH-RSA-DES-CBC3-SHA (168/168 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 50515B6EEA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Mar 2012 22:17:10 +1100 (EST)
From: Stefan Roese <sr@denx.de>
To: "Thang Q. Nguyen" <tqnguyen@apm.com>
Subject: Re: [PATCH 1/1] Add support 2 SATA ports for Maui and change filename
 from sata_dwc_460ex.c to sata_dwc_4xx.c
Date: Tue, 27 Mar 2012 13:16:54 +0200
References: <1332843983-24254-1-git-send-email-tqnguyen@apm.com>
In-Reply-To: <1332843983-24254-1-git-send-email-tqnguyen@apm.com>
MIME-Version: 1.0
Content-Type: Text/Plain;
  charset="iso-8859-15"
Message-Id: <201203271316.54562.sr@denx.de>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 netdev <netdev@vger.kernel.org>, linuxppc-dev@lists.ozlabs.org,
 David Miller <davem@davemloft.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tuesday 27 March 2012 12:26:23 Thang Q. Nguyen wrote:
> Support 2 native SATA ports on APM821XX and change the existing file name
> from sata_dwc_460ex.c to sata_dwc_4xx.c. This supports both 460EX and
> APM821XX.
> 
> Signed-off-by: Thang Q. Nguyen <tqnguyen@apm.com>
> ---
>  arch/powerpc/boot/dts/bluestone.dts |   21 +
>  drivers/ata/Makefile                |    2 +-
>  drivers/ata/sata_dwc_4xx.c          | 2178 +++++++++++++++++++++++++++++++++++
>  3 files changed, 2200 insertions(+), 1 deletions(-)
>  create mode 100644 drivers/ata/sata_dwc_4xx.c

Please use -M option (find-renames) while generating this patch to see
changes in the driver. And you missed to remove the "old" driver.

Thanks,
Stefan
