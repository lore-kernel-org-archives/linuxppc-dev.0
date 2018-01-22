Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zPxqd5fCjzF0Vy
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jan 2018 14:34:05 +1100 (AEDT)
In-Reply-To: <20170317011119.31091-1-david@gibson.dropbear.id.au>
To: David Gibson <david@gibson.dropbear.id.au>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, paulus@samba.org,
 linux-kernel@vger.kernel.org, David Gibson <david@gibson.dropbear.id.au>
Subject: Re: powerpc/pseries: Don't give a warning when HPT resizing isn't
 available
Message-Id: <3zPxqd4pBfz9sBZ@ozlabs.org>
Date: Mon, 22 Jan 2018 14:34:05 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-03-17 at 01:11:19 UTC, David Gibson wrote:
> As of 438cc81a41 "powerpc/pseries: Automatically resize HPT for memory hot
> add/remove" when running on the pseries platform, we always attempt to
> use the PAPR extension to resize the hashed page table (HPT) when we add
> or remove memory.
> 
> This is fine, but when the extension is available we'll give a harmless,
> but scary warning.  This patch suppresses the warning in this case.  It
> will still warn if the feature is supposed to be available, but didn't
> work.
> 
> Signed-off-by: David Gibson <david@gibson.dropbear.id.au>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/7339390d772ddee0447886d72c3aeb

cheers
