Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 7F102DDF3F
	for <linuxppc-dev@ozlabs.org>; Fri, 10 Apr 2009 09:38:58 +1000 (EST)
Date: Thu, 9 Apr 2009 16:34:03 -0700
From: Andrew Morton <akpm@linux-foundation.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
Message-Id: <20090409163403.e82ec1c3.akpm@linux-foundation.org>
In-Reply-To: <Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
	<Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: yanok@emcraft.com, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	prodyuth@gmail.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Mon, 6 Apr 2009 22:01:15 +0100 (BST)
Hugh Dickins <hugh@veritas.com> wrote:

> Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
> let powerpc 256kB pages coexist with CONFIG_SHMEM again.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> Added linuxppc-dev and some other Cc's for this 3/3: sorry
> if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.

Do we think these patches should be in 2.6.30?
