Return-Path: <benh@kernel.crashing.org>
Subject: Re: [patch 0/6] Strong Access Ordering page attributes for POWER7
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: shaggy@linux.vnet.ibm.com
In-Reply-To: <20080618223254.966080905@linux.vnet.ibm.com>
References: <20080618223254.966080905@linux.vnet.ibm.com>
Content-Type: text/plain
Date: Fri, 04 Jul 2008 09:39:52 +1000
Message-Id: <1215128392.7960.7.camel@pasglop>
Mime-Version: 1.0
Cc: linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
	Paul Mackerras <paulus@au1.ibm.com>, Linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-06-18 at 17:32 -0500, shaggy@linux.vnet.ibm.com wrote:
> Andrew,
> 
> The first patch in this series hits architecture independent code, but the
> rest is contained in the powerpc subtree.  Could you pick up the first
> patch into -mm?  I can send the rest of them through the powerpc git tree.
> The first patch and the rest of the set are independent and can be merged
> in either order.

 ../..

I was wondering... how do we inform userspace that this is available ?
Same question with adding the endian bit on 4xx which I plan to do using
your infrastructure...

We haven't defined a user-visible feature bit (and besides, we're really
getting short on these...). This is becoming a bit of concern btw (the
running out of bits). Maybe we should start defining an AT_HWCAP2 for
powerpc and get libc updated to pick it up ?

Ben.
