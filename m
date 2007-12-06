Return-Path: <jwboyer@linux.vnet.ibm.com>
Received: from e4.ny.us.ibm.com (e4.ny.us.ibm.com [32.97.182.144])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e4.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 67917DDF64
	for <linuxppc-dev@ozlabs.org>; Fri,  7 Dec 2007 06:59:32 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e4.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id lB6JxUPG013917
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 14:59:30 -0500
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	lB6JxTCI125114
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 14:59:29 -0500
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	lB6JxT3h023046
	for <linuxppc-dev@ozlabs.org>; Thu, 6 Dec 2007 14:59:29 -0500
Date: Thu, 6 Dec 2007 13:56:37 -0600
From: Josh Boyer <jwboyer@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 18/25] powerpc: Base support for 440GX Taishan eval board
Message-ID: <20071206135637.49bb1ce3@zod.rchland.ibm.com>
In-Reply-To: <20071206080129.737E8DE09F@ozlabs.org>
References: <1196927999.714593.205329520306.qpush@grosgo>
	<20071206080129.737E8DE09F@ozlabs.org>
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

On Thu, 06 Dec 2007 19:00:18 +1100
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> From: Hugh Blemings <hugh@blemings.org>
> 
> 
> Signed-off-by: Hugh Blemings <hugh@blemings.org>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> 
> This needs a bit of cleanup still, probably not to be merged as-is
> just yet (like using mtdcri/mfdcri for CPR access).

A defconfig for it would be nice.

josh
