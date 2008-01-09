Return-Path: <dgibson@ozlabs.org>
Date: Thu, 10 Jan 2008 10:48:03 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Liu Yu <Yu.Liu@freescale.com>
Subject: Re: [PATCH] Fix remainder calculating bug in single floating point
	division
Message-ID: <20080109234803.GB17153@localhost.localdomain>
References: <11996296134110-git-send-email-Yu.Liu@freescale.com>
	<CC561FA6-0590-4BC0-B42B-7EE1B379CE8E@kernel.crashing.org>
	<6EBEC19BF4A8F843BCD6B9155BBE2515D1B515@zch01exm26.fsl.freescale.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <6EBEC19BF4A8F843BCD6B9155BBE2515D1B515@zch01exm26.fsl.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Jan 09, 2008 at 09:24:07AM +0800, Liu Yu wrote:
> 
> > 
> > can you provide the test case that shows the error.
> > 
> 
> It seems that math-emu only be used for MPC8xx on current kernel.

It can be used for IBM/AMCC 4xx too.

-- 
David Gibson			| I'll have my music baroque, and my code
david AT gibson.dropbear.id.au	| minimalist, thank you.  NOT _the_ _other_
				| _way_ _around_!
http://www.ozlabs.org/~dgibson
