Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnW3Y01TXzDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 22:36:09 +1100 (AEDT)
In-Reply-To: <20161202023552.GJ2697@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Alexander Graf <agraf@suse.de>
Subject: Re: [1/2] powerpc: Remove Mac-on-Linux hooks
Message-Id: <3vnW3X6VPpz9s7v@ozlabs.org>
Date: Tue, 21 Mar 2017 22:36:08 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-12-02 at 02:35:52 UTC, Ben Hutchings wrote:
> The symbols exported for use by MOL aren't getting CRCs and I was
> about to fix that.  But MOL is dead upstream, and the latest work on
> it was to make it use KVM instead of its own kernel module.  So remove
> them instead.
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/3072601375ffff92bddd0ce810dd64

cheers
