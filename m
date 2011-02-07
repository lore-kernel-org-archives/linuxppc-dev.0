Return-Path: <greg@kroah.com>
Received: from coco.kroah.org (kroah.org [198.145.64.141])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "coco.kroah.org", Issuer "Greg KH" (not verified))
	by ozlabs.org (Postfix) with ESMTPS id 07EDFB7110
	for <linuxppc-dev@lists.ozlabs.org>;
	Mon,  7 Feb 2011 12:43:48 +1100 (EST)
Date: Sun, 6 Feb 2011 17:42:05 -0800
From: Greg KH <greg@kroah.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH 3/4]Define memory_block_size_bytes for powerpc/pseries
Message-ID: <20110207014205.GA16217@kroah.com>
References: <4D386498.9080201@austin.ibm.com> <4D3866A0.6010803@austin.ibm.com>
	<1297035563.14982.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1297035563.14982.15.camel@pasglop>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org, Robin Holt <holt@sgi.com>,
	linuxppc-dev@lists.ozlabs.org,
	KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 07, 2011 at 10:39:23AM +1100, Benjamin Herrenschmidt wrote:
> On Thu, 2011-01-20 at 10:45 -0600, Nathan Fontenot wrote:
> > Define a version of memory_block_size_bytes() for powerpc/pseries such that
> > a memory block spans an entire lmb.
> > 
> > Signed-off-by: Nathan Fontenot <nfont@austin.ibm.com>
> > Reviewed-by: Robin Holt <holt@sgi.com>
> 
> Hi Nathan !
> 
> Is somebody from -mm picking the rest of the series ? This patch as well
> or shall I wait for the first two to go in and then pick that one in
> -powerpc ?

I took all of these in my tree already, is that ok?

thanks,

greg k-h
