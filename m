Return-Path: <jmorris@namei.org>
Received: from us.intercode.com.au (namei.org [69.55.235.186])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 5DA02DDFD2
	for <linuxppc-dev@ozlabs.org>; Mon, 28 Jul 2008 11:44:13 +1000 (EST)
Date: Mon, 28 Jul 2008 11:07:40 +1000 (EST)
From: James Morris <jmorris@namei.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH] powerpc/ibmveth: fix multiple errors with
	dma_mapping_error conversion
In-Reply-To: <20080728103253.5256e6c0.sfr@canb.auug.org.au>
Message-ID: <Xine.LNX.4.64.0807281101310.19550@us.intercode.com.au>
References: <20080728021424.40cf66bc.sfr@canb.auug.org.au>
	<20080727122414.cac4e336.akpm@linux-foundation.org>
	<20080728103253.5256e6c0.sfr@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jeff Garzik <jeff@garzik.org>, LKML <linux-kernel@vger.kernel.org>,
	FUJITA Tomonori <fujita.tomonori@lab.ntt.co.jp>,
	ppc-dev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Andrew Morton <akpm@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 28 Jul 2008, Stephen Rothwell wrote:

> I hope that we all can discuss procedures for API changes at the Kernel
> Summit ...

"all" as in, whoever was invited (the only transparent aspect of was a 
silly count of # of commits for the initial shortlist), or was on the 
committee, or bought seats via sponsorship.



- James (co- maintainer/author of several kernel subsystems over 8+ years 
and apparently not invited, because ?)


-- 
James Morris
<jmorris@namei.org>
