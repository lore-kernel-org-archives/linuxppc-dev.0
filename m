Return-Path: <horms@verge.net.au>
Received: from koto.vergenet.net (koto.vergenet.net [210.128.90.7])
	by ozlabs.org (Postfix) with ESMTP id 520DFDDE39
	for <linuxppc-dev@ozlabs.org>; Tue, 19 Jun 2007 15:06:42 +1000 (EST)
Date: Tue, 19 Jun 2007 14:06:35 +0900
From: Horms <horms@verge.net.au>
To: Michael Neuling <mikey@neuling.org>
Subject: Re: [PATCH] kexec ppc64: fix misaligned cmdline
Message-ID: <20070619050633.GA11878@verge.net.au>
References: <25445.1180941825@neuling.org>
	<8f5d8a214e9042b0c556ac7256928a52@bga.com>
	<26608.1180950136@neuling.org> <10188.1181179162@neuling.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <10188.1181179162@neuling.org>
Cc: linuxppc-dev@ozlabs.org, kexec@lists.infradead.org,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Jun 07, 2007 at 11:19:22AM +1000, Michael Neuling wrote:
> If the cmdline changes between boots, we can get misalignment of the
> bootargs entry, which in turn corrupts our device tree blob and hence
> kills our kexec boot.  Also, if there was no /chosen/bootargs
> previously, we'd never add a new one. 
> 
> This ignores the bootargs while parsing the tree and inserts it later. 
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>

Thanks, applied.

-- 
Horms
  H: http://www.vergenet.net/~horms/
  W: http://www.valinux.co.jp/en/
