Return-Path: <ak@suse.de>
Received: from mx1.suse.de (ns.suse.de [195.135.220.2])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx1.suse.de", Issuer "CAcert Class 3 Root" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B854ADDDF3
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Sep 2007 19:54:58 +1000 (EST)
From: Andi Kleen <ak@suse.de>
To: travis@sgi.com
Subject: Re: [PATCH 00/10] x86: Reduce Memory Usage and Inter-Node message
	traffic (v3)
Date: Thu, 13 Sep 2007 11:53:32 +0200
References: <20070912015644.927677070@sgi.com>
In-Reply-To: <20070912015644.927677070@sgi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Message-Id: <200709131153.32576.ak@suse.de>
Cc: linux-mm@kvack.org, linux-kernel@vger.kernel.org, linuxppc-dev@ozlabs.org,
	sparclinux@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>,
	Christoph Lameter <clameter@sgi.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wednesday 12 September 2007 03:56, travis@sgi.com wrote:
> Note:
>
> This patch consolidates all the previous patches regarding
> the conversion of static arrays sized by NR_CPUS into per_cpu
> data arrays and is referenced against 2.6.23-rc6 .


Looks good to me from the x86 side. I'll leave it to Andrew to
handle for now though because it touches too many files
outside x86.

-Andi
