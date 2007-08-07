Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 8F0CDDDD01
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  8 Aug 2007 07:19:59 +1000 (EST)
Message-ID: <46B8E1F9.3000404@garzik.org>
Date: Tue, 07 Aug 2007 17:19:53 -0400
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: leoli@freescale.com
Subject: Re: [GIT PATCH] ucc_geth fixes for 2.6.22-rc1
References: <1186132075.6230.11.camel@Gundam>
In-Reply-To: <1186132075.6230.11.camel@Gundam>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-embedded@ozlabs.org
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Li Yang wrote:
> Please pull from 'ucc_geth' branch of
> master.kernel.org:/pub/scm/linux/kernel/git/leo/fsl-soc.git ucc_geth
> 
> to receive the following fixes:
> 
>  drivers/net/ucc_geth_ethtool.c |    1 -
>  drivers/net/ucc_geth_mii.c     |    3 ++-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Domen Puncer (1):
>       ucc_geth: fix section mismatch
> 
> Jan Altenberg (1):
>       ucc_geth: remove get_perm_addr from ucc_geth_ethtool.c

pulled
