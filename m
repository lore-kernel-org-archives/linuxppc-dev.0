Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E2C70679EA
	for <linuxppc-dev@ozlabs.org>; Mon,  1 May 2006 16:51:29 +1000 (EST)
Subject: Re: [PATCH] powerpc: Use the ibm,pa-features property where available
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
In-Reply-To: <17493.35040.453321.909465@cargo.ozlabs.ibm.com>
References: <17493.35040.453321.909465@cargo.ozlabs.ibm.com>
Content-Type: text/plain
Date: Mon, 01 May 2006 16:51:21 +1000
Message-Id: <1146466281.30710.32.camel@localhost.localdomain>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 2006-05-01 at 14:04 +1000, Paul Mackerras wrote:
> Forthcoming IBM machines will have a "ibm,pa-features" property on CPU
> nodes, that contains bits indicating which optional architecture
> features are implemented by the CPU.  This adds code to use the
> property, if present, to update our CPU feature bitmaps.
> 
> This is based on a patch by Will Schmidt <will_schmidt@vnet.ibm.com>

We should also remove all the bits potentially found in the property
before hand...

Ben.
