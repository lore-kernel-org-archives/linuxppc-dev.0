Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tMc7l2NSfzDt3R
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 21 Nov 2016 16:08:35 +1100 (AEDT)
Date: Mon, 21 Nov 2016 16:04:46 +1100
From: Paul Mackerras <paulus@ozlabs.org>
To: Daniel Axtens <dja@axtens.net>
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
Subject: Re: [PATCH 1/2] KVM: PPC: Fix sparse static warning.
Message-ID: <20161121050446.GH26748@fergus.ozlabs.ibm.com>
References: <1476059480-18145-1-git-send-email-dja@axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1476059480-18145-1-git-send-email-dja@axtens.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 10, 2016 at 11:31:19AM +1100, Daniel Axtens wrote:
> Squash a couple of sparse warnings by making things static.
> 
> Build tested.
> 
> Signed-off-by: Daniel Axtens <dja@axtens.net>

Thanks, applied to kvm-ppc-next.

Paul.
