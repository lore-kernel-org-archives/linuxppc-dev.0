Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18520.16578.683443.232089@cargo.ozlabs.ibm.com>
Date: Wed, 18 Jun 2008 08:54:58 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH v2] powerpc/booke: Add support for new e500mc core
In-Reply-To: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
References: <Pine.LNX.4.64.0806170901140.15775@blarg.am.freescale.net>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> The new e500mc core from Freescale is based on the e500v2 but with the
> following changes:
> 
> * Supports only the Enhanced Debug Architecture (DSRR0/1, etc)
> * Floating Point
> * No SPE
> * Supports lwsync
> * Doorbell Exceptions
> * Hypervisor

Isn't the cache line size different too?  If so you should mention
that in this list.

Paul.
