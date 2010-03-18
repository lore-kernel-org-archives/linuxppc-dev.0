Return-Path: <jochen@scram.de>
Received: from mail.scram.de (mail0.scram.de [78.47.204.202])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mail.scram.de",
	Issuer "StartCom Class 1 Primary Intermediate Server CA" (not
	verified)) by ozlabs.org (Postfix) with ESMTPS id 7CE45B7D70
	for <linuxppc-dev@lists.ozlabs.org>;
	Fri, 19 Mar 2010 03:11:07 +1100 (EST)
Message-ID: <4BA24DA8.9030309@scram.de>
Date: Thu, 18 Mar 2010 16:58:32 +0100
From: Jochen Friedrich <jochen@scram.de>
MIME-Version: 1.0
To: Grant Likely <grant.likely@secretlab.ca>
Subject: Re: [V2 PATCH 06/10] of/drivers: Always use struct device.of_node
	to get	node pointer
References: <20100318144836.21082.93040.stgit@angua>
	<20100318152238.21082.10985.stgit@angua>
In-Reply-To: <20100318152238.21082.10985.stgit@angua>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linux-kernel@vger.kernel.org, michal.simek@petalogix.com,
	microblaze-uclinux@itee.uq.edu.au, sparclinux@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Grant,

> The following structure elements duplicate the information in
> 'struct device.of_node' and so are being eliminated.  This patches
> makes all readers of the following elements use device.of_node instead.
> 
> struct dev_archdata.prom_node (sparc)
> struct dev_archdata.of_node (powerpc)
> struct of_device.node
> 
> Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
> ---
> 
>  drivers/i2c/busses/i2c-ibm_iic.c              |    4 ++--
>  drivers/i2c/busses/i2c-mpc.c                  |   17 ++++++++-------

drivers/i2c/busses/i2c-cpm.c is missing in this patch.

Thanks,
Jochen
