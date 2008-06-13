Return-Path: <jgarzik@pobox.com>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F79FDDFF7
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jun 2008 05:56:02 +1000 (EST)
Message-ID: <4852D0BD.7010403@pobox.com>
Date: Fri, 13 Jun 2008 15:55:41 -0400
From: Jeff Garzik <jgarzik@pobox.com>
MIME-Version: 1.0
To: Brian King <brking@linux.vnet.ibm.com>
Subject: Re: [PATCH 10/19] [repost] powerpc: move get_longbusy_msecs out of
	ehca/ehea
References: <20080612221848.GR30916@linux.vnet.ibm.com>
	<4852BB43.9080305@linux.vnet.ibm.com>
In-Reply-To: <4852BB43.9080305@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: netdev@vger.kernel.org, linuxppc-dev@ozlabs.org, paulus@samba.org,
	David Darrington <ddarring@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Brian King wrote:
> Jeff,
> 
> Regarding the patches Rob just posted here, we'd like to just take them
> through the powerpc tree with your sign off since they are part of a
> Power platform feature we are enabling.
> 
> Thanks,
> 
> Brian
> 
> Robert Jennings wrote:
>> From: Robert Jennings <rcj@linux.vnet.ibm.com>
>>
>> In support of Cooperative Memory Overcommitment (CMO) this moves
>> get_longbusy_msecs() out of the ehca and ehea drivers and into the 
>> architecture's hvcall header as plpar_get_longbusy_msecs.  Some firmware
>> calls made in pSeries platform iommu code will need to share this
>> functionality.
>>
>> Signed-off-by: Robert Jennings <rcj@linux.vnet.ibm.com>
>>
>> ---
>>
>> I missed copying netdev on this patch the first time.
>>
>>  drivers/infiniband/hw/ehca/hcp_if.c |   24 ++----------------------
>>  drivers/net/ehea/ehea_phyp.c        |    4 ++--
>>  drivers/net/ehea/ehea_phyp.h        |   20 --------------------
>>  include/asm-powerpc/hvcall.h        |   27 +++++++++++++++++++++++++++
>>  4 files changed, 31 insertions(+), 44 deletions(-)

ACK the quoted patch
