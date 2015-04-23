Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 502861A0C17
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2015 17:24:39 +1000 (AEST)
Message-ID: <1429773878.4672.7.camel@ellerman.id.au>
Subject: Re: [PATCH] kvm: powerpc: Fix ppc64_defconfig + PPC_POWERNV=n build
 error
From: Michael Ellerman <mpe@ellerman.id.au>
To: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
Date: Thu, 23 Apr 2015 17:24:38 +1000
In-Reply-To: <553877FB.4040507@linux.vnet.ibm.com>
References: <1429181889-1448-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <553877FB.4040507@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, agraf@suse.de,
 linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2015-04-23 at 10:11 +0530, Shreyas B Prabhu wrote:
> Any suggestions on this?

It's in:

https://git.kernel.org/cgit/linux/kernel/git/mpe/linux.git/log/?h=fixes

cheers
