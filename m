Return-Path: <paulus@bilbo.ozlabs.org>
Received: from bilbo.ozlabs.org (bilbo.ozlabs.org [203.10.76.25])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "bilbo.ozlabs.org",
	Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id B8B59DDF4B
	for <linuxppc-dev@ozlabs.org>; Tue,  7 Apr 2009 13:28:48 +1000 (EST)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <18906.51307.281300.189948@drongo.ozlabs.ibm.com>
Date: Tue, 7 Apr 2009 13:28:43 +1000
From: Paul Mackerras <paulus@samba.org>
To: Hugh Dickins <hugh@veritas.com>
Subject: Re: [PATCH 3/3] powerpc: allow 256kB pages with SHMEM
In-Reply-To: <Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
References: <Pine.LNX.4.64.0904062151250.21044@blonde.anvils>
	<Pine.LNX.4.64.0904062156290.21044@blonde.anvils>
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	prodyuth@gmail.com, linux-kernel@vger.kernel.org, yanok@emcraft.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hugh Dickins writes:

> Now that shmem's divisions by zero and SHMEM_MAX_BYTES are fixed,
> let powerpc 256kB pages coexist with CONFIG_SHMEM again.
> 
> Signed-off-by: Hugh Dickins <hugh@veritas.com>
> ---
> Added linuxppc-dev and some other Cc's for this 3/3: sorry
> if you didn't see 1/3 and 2/3, they were just in mm/shmem.c.

Looks OK - what path are you using to get the series upstream?
(I.e. should I be putting 3/3 in the powerpc tree or are you going to
push it along with the others?)

Paul.
