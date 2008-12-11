Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e1.ny.us.ibm.com (e1.ny.us.ibm.com [32.97.182.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e1.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 38865DDF6B
	for <linuxppc-dev@ozlabs.org>; Fri, 12 Dec 2008 01:35:27 +1100 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e1.ny.us.ibm.com (8.13.1/8.13.1) with ESMTP id mBBEYhrd019574
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:34:43 -0500
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	mBBEZNou180536
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 09:35:23 -0500
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	mBBFZXP1004837
	for <linuxppc-dev@ozlabs.org>; Thu, 11 Dec 2008 10:35:33 -0500
Date: Thu, 11 Dec 2008 09:35:17 -0500
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Matteo Fortini <m.fortini@selcomgroup.com>
Subject: Re: [PATCH] ADS5121 Fix: put dummy byte to enable fixing EOF bug to
	first place in order not to break some drivers\nUse ALARM interrupt to
	avoid waiting for data to come in
Message-ID: <20081211093517.31741578@zod.rchland.ibm.com>
In-Reply-To: <49400F56.2040008@selcomgroup.com>
References: <49400F56.2040008@selcomgroup.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, John Rigby <jrigby@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 10 Dec 2008 19:49:58 +0100
Matteo Fortini <m.fortini@selcomgroup.com> wrote:

>  From d500e922b750a2bea554d32d8f12937f4da9c80a Mon Sep 17 00:00:00 2001
> From: Matteo Fortini <m.fortini@selcomgroup.com>
> Date: Wed, 10 Dec 2008 19:33:16 +0100
> Subject: [PATCH] Fix: put dummy byte to enable fixing EOF bug to first 
> place in order not to break some drivers
>  Use ALARM interrupt to avoid waiting for data to come in
> 
> 
> Signed-off-by: Matteo Fortini <m.fortini@selcomgroup.com>
> ---
>  drivers/spi/mpc512x_psc_spi.c |   53 
> ++++++++++++++++++++++++-----------------
>  1 files changed, 31 insertions(+), 22 deletions(-)

This patch is whitespace corrupted.

josh
