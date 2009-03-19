Return-Path: <dgibson@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B04A6DDD1C
	for <linuxppc-dev@ozlabs.org>; Thu, 19 Mar 2009 11:11:35 +1100 (EST)
Date: Thu, 19 Mar 2009 11:05:33 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Martyn Welch <martyn.welch@gefanuc.com>
Subject: Re: [PATCH v3 1/2] powerpc/86xx: Board support for GE Fanuc's PPC9A
Message-ID: <20090319000533.GA20163@yookeroo.seuss>
References: <20090318122501.25609.11105.stgit@ubuntu8041.localdomain>
	<20090318122914.25609.765.stgit@ubuntu8041.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20090318122914.25609.765.stgit@ubuntu8041.localdomain>
Cc: linuxppc-dev@ozlabs.org, wim@iguana.be
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 18, 2009 at 12:29:15PM +0000, Martyn Welch wrote:
> Support for the PPC9A VME Single Board Computer from GE Fanuc (PowerPC
> MPC8641D).
> 
> This is the basic board support for GE Fanuc's PPC9A, a 6U single board
> computer, based on Freescale's MPC8641D.

One tiny nit left..

[snip]
> +		flash@1,0 {
> +			compatible = "gef, ppc9a-paged-flash", "cfi-flash";

The space in the compatible string is probably not a good idea.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
