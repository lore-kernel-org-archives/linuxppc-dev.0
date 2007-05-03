Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17977.49450.564147.751969@cargo.ozlabs.ibm.com>
Date: Thu, 3 May 2007 21:02:02 +1000
From: Paul Mackerras <paulus@samba.org>
To: Jon Loeliger <jdl@freescale.com>
Subject: Re: [PATCH] Remove CPU_FTR_NEED_COHERENT for 7448.
In-Reply-To: <1178141683.32136.46.camel@ld0161-tx32>
References: <1178141683.32136.46.camel@ld0161-tx32>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger writes:

> From: James.Yang <James.Yang@freescale.com>
> 
> Remove CPU_FTR_NEED_COHERENT for MPC7448 (and single-core MPC86xx).
> This prevents needlessly setting M=1 when not SMP.

Do you have any benchmark results showing a real performance
improvement from these?

Paul.
