Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e32.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 957D8DDFDE
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Feb 2008 23:50:07 +1100 (EST)
Received: from d03relay04.boulder.ibm.com (d03relay04.boulder.ibm.com
	[9.17.195.106])
	by e32.co.us.ibm.com (8.13.8/8.13.8) with ESMTP id m16BkL3T004394
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 06:46:21 -0500
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
	by d03relay04.boulder.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m16Co2GT087062
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 05:50:02 -0700
Received: from d03av02.boulder.ibm.com (loopback [127.0.0.1])
	by d03av02.boulder.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m16Co1hi015828
	for <linuxppc-dev@ozlabs.org>; Wed, 6 Feb 2008 05:50:02 -0700
Date: Wed, 6 Feb 2008 06:49:47 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] net: NEWEMAC: Remove "rgmii-interface" from rgmii
	matching table
Message-ID: <20080206064947.7e91d833@zod.rchland.ibm.com>
In-Reply-To: <1202300519-7294-1-git-send-email-sr@denx.de>
References: <1202300519-7294-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, netdev@vger.kernel.org, jeff@garzik.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed,  6 Feb 2008 13:21:59 +0100
Stefan Roese <sr@denx.de> wrote:

> With the removal the the "rgmii-interface" device_type property from the
> dts files, the newemac driver needs an update to only rely on compatible
> property.
> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Acked-by: Josh Boyer <jwboyer@linux.vnet.ibm.com>

josh
