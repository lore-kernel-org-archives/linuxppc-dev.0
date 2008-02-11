Return-Path: <jeff@garzik.org>
Received: from mail.dvmed.net (srv5.dvmed.net [207.36.208.214])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 5044CDDF7F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Feb 2008 03:08:51 +1100 (EST)
Message-ID: <47B072F1.4040605@garzik.org>
Date: Mon, 11 Feb 2008 11:08:17 -0500
From: Jeff Garzik <jeff@garzik.org>
MIME-Version: 1.0
To: Josh Boyer <jwboyer@linux.vnet.ibm.com>
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii matching
	table
References: <1202300519-7294-1-git-send-email-sr@denx.de>
	<20080206064947.7e91d833@zod.rchland.ibm.com>
In-Reply-To: <20080206064947.7e91d833@zod.rchland.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, Stefan Roese <sr@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Josh Boyer wrote:
> On Wed,  6 Feb 2008 13:21:59 +0100
> Stefan Roese <sr@denx.de> wrote:
> 
>> With the removal the the "rgmii-interface" device_type property from the
>> dts files, the newemac driver needs an update to only rely on compatible
>> property.
>>
>> Signed-off-by: Stefan Roese <sr@denx.de>
>> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> 
> Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

upon further reflection, ACK, take this via ppc tree
