Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 410B81A0743
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 20:45:57 +1100 (AEDT)
In-Reply-To: <1455689164-12128-1-git-send-email-ruscur@russell.cc>
To: Russell Currey <ruscur@russell.cc>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: linux-pci@vger.kernel.org, gwshan@linux.vnet.ibm.com
Subject: Re: MAINTAINERS: Update EEH details and maintainership
Message-Id: <20160222094557.21B43140C49@ozlabs.org>
Date: Mon, 22 Feb 2016 20:45:57 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2016-17-02 at 06:06:04 UTC, Russell Currey wrote:
> Enhanced Error Handling could mean anything in the context of the entire
> kernel, so change the name to reference that it is both for PCI and
> powerpc.
> 
> EEH covers a bit more than the previously listed files, so add the headers
> and platform-specific code to the EEH maintained section.
> 
> In addition, I am taking over the maintainership.
> 
> Signed-off-by: Russell Currey <ruscur@russell.cc>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/78c1cffdab7e5fc316be7d6a07

cheers
