Return-Path: <acme@kernel.org>
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zj4ZW0ZzpzF1JY
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Feb 2018 05:30:11 +1100 (AEDT)
Date: Thu, 15 Feb 2018 10:43:36 -0300
From: Arnaldo Carvalho de Melo <acme@kernel.org>
To: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>
Cc: alexander.shishkin@linux.intel.com, jolsa@redhat.com,
 namhyung@kernel.org, linux-kernel@vger.kernel.org,
 brueckner@linux.vnet.ibm.com, tmricht@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, mpe@ellerman.id.au
Subject: Re: [PATCH 0/3] perf trace powerpc: Remove libaudit dependency for
 syscalls
Message-ID: <20180215134336.GD22818@kernel.org>
References: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180129083417.31240-1-ravi.bangoria@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Em Mon, Jan 29, 2018 at 02:04:14PM +0530, Ravi Bangoria escreveu:
> This is almost identical set of patches recently done for s390.
> 
> With this, user can run perf trace without libaudit on powerpc
> as well. Ex,
> 
>   $ make
>     ...     libaudit: [ OFF ]
> 
>   $ ./perf trace ls

Thanks, applied.

- Arnaldo
