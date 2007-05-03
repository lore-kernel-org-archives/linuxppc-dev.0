Return-Path: <jdl@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 68A4BDDEA3
	for <linuxppc-dev@ozlabs.org>; Fri,  4 May 2007 02:04:56 +1000 (EST)
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
From: Jon Loeliger <jdl@freescale.com>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17977.49450.564147.751969@cargo.ozlabs.ibm.com>
References: <1178141683.32136.46.camel@ld0161-tx32>
	<17977.49450.564147.751969@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Message-Id: <1178208290.17201.43.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Thu, 03 May 2007 11:04:50 -0500
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, 2007-05-03 at 06:02, Paul Mackerras wrote:

> Do you have any benchmark results showing a real performance
> improvement from these?
> 
> Paul.

Yes.  We have the data to back this claim up.

jdl
