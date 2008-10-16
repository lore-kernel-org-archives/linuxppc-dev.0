Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1F92ADDF1D
	for <linuxppc-dev@ozlabs.org>; Thu, 16 Oct 2008 16:22:31 +1100 (EST)
Subject: Re: powerpc allmodconfig
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: David Miller <davem@davemloft.net>
In-Reply-To: <20081015.220247.262683261.davem@davemloft.net>
References: <20081015213337.a99a9595.akpm@linux-foundation.org>
	<20081015.220247.262683261.davem@davemloft.net>
Content-Type: text/plain
Date: Thu, 16 Oct 2008 16:21:47 +1100
Message-Id: <1224134507.8157.551.camel@pasglop>
Mime-Version: 1.0
Cc: linux-ide@vger.kernel.org, bzolnier@gmail.com, linuxppc-dev@ozlabs.org,
	tiwai@suse.de, netdev@vger.kernel.org,
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
	ralf@linux-mips.org, mark.fasheh@oracle.com,
	marek.vasut@gmail.com, akpm@linux-foundation.org,
	linux-ext4@vger.kernel.org, dwmw2@infradead.org,
	dan.j.williams@intel.com, mchehab@infradead.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2008-10-15 at 22:02 -0700, David Miller wrote:
> From: Andrew Morton <akpm@linux-foundation.org>
> Date: Wed, 15 Oct 2008 21:33:37 -0700
> 
> > kernel/resource.c: In function '__reserve_region_with_split':
> > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 3 has type 'resource_size_t'
> > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 4 has type 'resource_size_t'
> > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 6 has type 'resource_size_t'
> > kernel/resource.c:554: warning: format '%llx' expects type 'long long unsigned int', but argument 7 has type 'resource_size_t'
> 
> Known issue, Ben wants to add a new variant of %pX in order to print resources so that
> resource_size_t vs. unsigned long stuff doesn't matter like this any more.

Actually, I was told Linus had one and I've been trying to dig it out...

Oh well, I may as well dig my own old one.

Cheers,
Ben.
