Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17348.37558.434652.697604@cargo.ozlabs.ibm.com>
Date: Wed, 11 Jan 2006 16:08:06 +1100
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@gate.crashing.org>
In-Reply-To: <Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
References: <17348.35120.840409.283964@cargo.ozlabs.ibm.com>
	<Pine.LNX.4.44.0601102238530.15824-100000@gate.crashing.org>
Cc: linuxppc-dev@ozlabs.org, sjmunroe@us.ibm.com, linuxppc64-dev@ozlabs.org
Subject: Re: [PATCH] implement AT_PLATFORM for powerpc
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Kumar Gala writes:

> We should probably add two new AT_PLATFORM: "ppc8548" and "ppc5554".  
> "ppc8548" should be used for e500v2, and "ppc5554" for "e200z6".

How different are they in user-level ISA or in instruction scheduling
requirements?

> You aren't seeting PPC_FEATURE_BOOKE for anything.  We need to be a little 
> careful since 'isel' isn't implemented in the very first 440's.

Oops, I must have sent the wrong version of the patch.  Do we know
which 440s have or don't have isel?

Paul.
