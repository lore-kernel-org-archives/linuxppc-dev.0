Return-Path: <geoff@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:8b0:10b:1231::1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yHMdq4GvbzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Oct 2017 06:32:31 +1100 (AEDT)
Subject: Re: [PATCH 0/2] PowerPC-PS3: Adjustments for three function
 implementations
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Ellerman <mpe@ellerman.id.au>, Paul Mackerras <paulus@samba.org>
Cc: LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
References: <36a8ba41-7f1e-31f8-5d32-19e04393b181@users.sourceforge.net>
From: Geoff Levand <geoff@infradead.org>
Message-ID: <bc74497b-bf2b-01a1-b551-9374650b1f58@infradead.org>
Date: Wed, 18 Oct 2017 12:32:10 -0700
MIME-Version: 1.0
In-Reply-To: <36a8ba41-7f1e-31f8-5d32-19e04393b181@users.sourceforge.net>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/17/2017 11:54 AM, SF Markus Elfring wrote:
> Markus Elfring (2):
>   Delete an error message for a failed memory allocation in update_flash_db()
>   Improve a size determination in two functions

For consistency, please use 'powerpc/ps3' not 'powerpc-ps3' as
the commit log subject prefix.  Also, please try to keep the
commit log subject to 50 characters or less.

-Geoff
