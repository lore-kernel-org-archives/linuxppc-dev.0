Return-Path: <amodra@bigpond.net.au>
Received: from modra.org (CPE-144-136-221-26.sa.bigpond.net.au
	[144.136.221.26]) by ozlabs.org (Postfix) with ESMTP id 4A9AA67A7B
	for <linuxppc-dev@ozlabs.org>; Wed,  9 Mar 2005 12:26:55 +1100 (EST)
Date: Wed, 9 Mar 2005 11:49:29 +1030
From: Alan Modra <amodra@bigpond.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Message-ID: <20050309011929.GI15642@bubble.modra.org>
References: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20050309120343.0c22eb0f.sfr@canb.auug.org.au>
Cc: ppc64-dev <linuxppc64-dev@ozlabs.org>, ppc-dev <linuxppc-dev@ozlabs.org>
Subject: Re: [RFC][PATCH] combining header files
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 09, 2005 at 12:03:43PM +1100, Stephen Rothwell wrote:
> I would just like to start a discussion about consolidating (some of) the
> ppc and ppc64 header files.

Marvellous!  In case it isn't completely obvious, you can often share
structure definitions between ppc32 and ppc64 by judicious selection of
types.  eg.

struct stays_the_same {
  long long some_64bit_var;
  int some_32bit_var;
}

struct bigger_in_64bit {
  long var_sized_by_arch;
}

-- 
Alan Modra
IBM OzLabs - Linux Technology Centre
