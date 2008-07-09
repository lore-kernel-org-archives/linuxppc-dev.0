Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id C40A9DDE10
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Jul 2008 10:08:10 +1000 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m69083hQ015163
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:08:03 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.0) with ESMTP id
	m6907uFd135550
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:07:56 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m6907uTR013169
	for <linuxppc-dev@ozlabs.org>; Tue, 8 Jul 2008 20:07:56 -0400
Date: Tue, 8 Jul 2008 20:04:34 -0400
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Sean MacLennan <smaclennan@pikatech.com>
Subject: Re: [PATCH] powerpc: i2c-ibm_iic register child nodes
Message-ID: <20080708200434.6eb09506@zod.rchland.ibm.com>
In-Reply-To: <20080708162240.70b34046@lappy.seanm.ca>
References: <20080708144609.14bae1de@lappy.seanm.ca>
	<20080708162240.70b34046@lappy.seanm.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, 8 Jul 2008 16:22:40 -0400
Sean MacLennan <smaclennan@pikatech.com> wrote:

> Update the warp to use the new IBM IIC driver. We no longer need to
> register the I2C devices in the platform code.
> 
> Also adds a small bugfix for the i2c code if the i2c read fails.

I'll queue this up after Jean pulls in the i2c patch.

josh
