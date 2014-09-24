Return-Path: <anton@samba.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8F9F61A06F8
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Sep 2014 17:00:35 +1000 (EST)
Date: Wed, 24 Sep 2014 17:00:33 +1000
From: Anton Blanchard <anton@samba.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [PATCH 1/2] powerpc: Add VM_FAULT_HWPOISON handling to powerpc
 page fault handler
Message-ID: <20140924170033.43ee1c9c@kryten>
In-Reply-To: <20140924164005.2b142a4a@canb.auug.org.au>
References: <1411518427-14408-1-git-send-email-anton@samba.org>
 <20140924164005.2b142a4a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


Hi Stephen,

> If you had done this as 2 patches (one to remove the indent and a
> second to fix the actual problem), it would have been much easier to
> review ...

Good idea, I separated it out and resubmitted.

Anton
