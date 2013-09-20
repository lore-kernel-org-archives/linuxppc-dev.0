Return-Path: <heiko.carstens@de.ibm.com>
Received: from e06smtp12.uk.ibm.com (e06smtp12.uk.ibm.com [195.75.94.108])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e06smtp12.uk.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E58FD2C015D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Sep 2013 00:39:44 +1000 (EST)
Received: from /spool/local
 by e06smtp12.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <heiko.carstens@de.ibm.com>;
 Fri, 20 Sep 2013 15:39:36 +0100
Received: from b06cxnps3075.portsmouth.uk.ibm.com
 (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id AC03C17D8062
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 15:39:46 +0100 (BST)
Received: from d06av12.portsmouth.uk.ibm.com (d06av12.portsmouth.uk.ibm.com
 [9.149.37.247])
 by b06cxnps3075.portsmouth.uk.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r8KEdMxo61997224
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 14:39:22 GMT
Received: from d06av12.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av12.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r8KEdXHv008407
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 20 Sep 2013 08:39:34 -0600
Date: Fri, 20 Sep 2013 16:39:32 +0200
From: Heiko Carstens <heiko.carstens@de.ibm.com>
To: Anoop Thomas Mathew <atm@profoundis.com>
Subject: Re: [PATCH] Fixed typo on word accounting in kprobes.c in mutliple
 architectures
Message-ID: <20130920143932.GA4017@osiris>
References: <20130918210351.GA13811@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130918210351.GA13811@gmail.com>
Cc: linux-s390@vger.kernel.org, tony.luck@intel.com, linux-ia64@vger.kernel.org,
 vgupta@synopsys.com, linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org,
 Jiri Kosina <trivial@kernel.org>, akpm@linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Sep 19, 2013 at 02:33:58AM +0530, Anoop Thomas Mathew wrote:
> Signed-off-by: Anoop Thomas Mathew <atm@profoundis.com>
> ---
>  arch/arc/kernel/kprobes.c     |    2 +-
>  arch/ia64/kernel/kprobes.c    |    2 +-
>  arch/powerpc/kernel/kprobes.c |    2 +-
>  arch/s390/kernel/kprobes.c    |    2 +-
>  arch/sparc/kernel/kprobes.c   |    2 +-
>  5 files changed, 5 insertions(+), 5 deletions(-)

Please send trivial typo fixes to Jiri Kosina <trivial@kernel.org>.
See "TRIVIAL PATCHES" in MAINTAINERS. Thanks!
