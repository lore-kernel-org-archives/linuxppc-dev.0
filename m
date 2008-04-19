Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18441.58154.608911.337978@cargo.ozlabs.ibm.com>
Date: Sat, 19 Apr 2008 22:18:50 +1000
From: Paul Mackerras <paulus@samba.org>
To: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: Patches added to powerpc.git master and powerpc-next branches
In-Reply-To: <9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
References: <18440.34891.440661.248400@cargo.ozlabs.ibm.com>
	<9CE9EFA8-A303-49C9-B9A2-F62D42F927B7@kernel.crashing.org>
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

> [POWERPC] 85xx: Add support for relocatble kernel (and booting at non- 
> zero)

Should be OK to go though probably not in the first batch.  I want to
look through it carefully again since it's touching code that is
common to a lot of platforms.  The patch description looks reasonable
as to what it explains but the english could use a touch-up here or
there (e.g. "a physical address that is module 256M" doesn't actually
mean anything; "a physical address that is 0 modulo 256M" would be
correct).

> [POWERPC] Port fixmap from x86 and use for kmap_atomic

Once again I want to go through it carefully and understand how it all
works, and in particular understand things like the way it ensures
that the base address for the kmap region is aligned to a 4M boundary
so all the kmap ptes are in a single page (assuming it does :).

Paul.
