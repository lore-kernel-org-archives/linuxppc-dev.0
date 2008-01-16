Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 85F3FDDE11
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 23:41:42 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m0GCfdck028409
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 07:41:39 -0500
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m0GCfdxv120468
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 07:41:39 -0500
Received: from d01av03.pok.ibm.com (loopback [127.0.0.1])
	by d01av03.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m0GCfcQt031310
	for <linuxppc-dev@ozlabs.org>; Wed, 16 Jan 2008 07:41:38 -0500
Date: Wed, 16 Jan 2008 06:40:08 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Stefan Roese <sr@denx.de>
Subject: Re: [PATCH] [POWERPC] 4xx: Remove "i2c" and "xxmii-interface"
	device_types from dts
Message-ID: <20080116064008.390db210@zod.rchland.ibm.com>
In-Reply-To: <1200474000-5630-1-git-send-email-sr@denx.de>
References: <1200474000-5630-1-git-send-email-sr@denx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 16 Jan 2008 10:00:00 +0100
Stefan Roese <sr@denx.de> wrote:

> Remove all "i2c" and "xxmii-interface" (rgmii etc) device_type entries
> from the 4xx dts files.

Holding on this one until Ben or I can check Axon to see if it's DT can
handle no device_type for xxmii-interface.

josh
