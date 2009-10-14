Return-Path: <hollisb@us.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e37.co.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 07A6CB7334
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 15 Oct 2009 09:57:20 +1100 (EST)
Received: from d03relay05.boulder.ibm.com (d03relay05.boulder.ibm.com
	[9.17.195.107])
	by e37.co.us.ibm.com (8.14.3/8.13.1) with ESMTP id n9EMuAIr009123
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 16:56:10 -0600
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
	by d03relay05.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	n9EMvAGw141386
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 16:57:10 -0600
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
	by d03av06.boulder.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP
	id n9EMwaDJ027221
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2009 16:58:36 -0600
Subject: Re: linux-next: tree build failure
From: Hollis Blanchard <hollisb@us.ibm.com>
To: Jan Beulich <JBeulich@novell.com>
In-Reply-To: <1255115648.2546.71.camel@slab.beaverton.ibm.com>
References: <4AC1E15502000078000516B5@vpn.id2.novell.com>
	<1254267572.15622.1621.camel@slab.beaverton.ibm.com>
	<4AC318450200007800017355@vpn.id2.novell.com>
	<1254498517.3839.17.camel@slab.beaverton.ibm.com>
	<4AC9B5310200007800017EA1@vpn.id2.novell.com>
	<1255115648.2546.71.camel@slab.beaverton.ibm.com>
Content-Type: text/plain
Date: Wed, 14 Oct 2009 15:57:06 -0700
Message-Id: <1255561026.29192.0.camel@slab.beaverton.ibm.com>
Mime-Version: 1.0
Cc: sfr@canb.auug.org.au, Rusty Russell <rusty@rustcorp.com.au>,
	linux-kernel@vger.kernel.org, kvm-ppc@vger.kernel.org,
	linux-next@vger.kernel.org, akpm@linux-foundation.org,
	linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2009-10-09 at 12:14 -0700, Hollis Blanchard wrote:
> Rusty's version of BUILD_BUG_ON() does indeed fix the build break, and
> also exposes the bug in kvmppc_account_exit_stat(). So to recap:
> 
> original: built but didn't work
> Jan's: doesn't build
> Rusty's: builds and works
> 
> Where do you want to go from here?

Jan, what are your thoughts? Your BUILD_BUG_ON patch has broken the
build, and we still need to fix it.

-- 
Hollis Blanchard
IBM Linux Technology Center
