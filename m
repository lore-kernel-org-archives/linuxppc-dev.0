Return-Path: <amodra@bigpond.net.au>
Received: from omta04sl.mx.bigpond.com (omta04sl.mx.bigpond.com
	[144.140.93.156]) by ozlabs.org (Postfix) with ESMTP id C98D0DDF16
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 20:19:02 +1000 (EST)
Received: from oaamta04sl.mx.bigpond.com ([58.174.193.185])
	by omta04sl.mx.bigpond.com with ESMTP id
	<20071023101901.ELMO21837.omta04sl.mx.bigpond.com@oaamta04sl.mx.bigpond.com>
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Oct 2007 10:19:01 +0000
Date: Tue, 23 Oct 2007 19:49:01 +0930
From: Alan Modra <amodra@bigpond.net.au>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: Problems with allyesconfig kernel build
Message-ID: <20071023101900.GA21738@bubble.grove.modra.org>
References: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071023140231.12698d1c.sfr@canb.auug.org.au>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Oct 23, 2007 at 02:02:31PM +1000, Stephen Rothwell wrote:
> Anyone have any ideas?

The segfault with --emit-relocs and complaints about .fixup are linker
bugs.  I'm about the commit fixes for both of these problems.

-- 
Alan Modra
Australia Development Lab, IBM
