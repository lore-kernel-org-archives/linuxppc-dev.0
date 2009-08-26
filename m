Return-Path: <galak@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 07D74B70CF
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 26 Aug 2009 12:24:07 +1000 (EST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1E6A1DDD1B
	for <linuxppc-dev@ozlabs.org>; Wed, 26 Aug 2009 12:24:05 +1000 (EST)
Message-Id: <B3C29A62-ED34-4C07-8E5B-FF5C9ADE5F71@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1251253245-16616-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v936)
Subject: Re: [PATCH] powerpc/pci: Pull ppc32 PCI features into common
Date: Tue, 25 Aug 2009 21:23:53 -0500
References: <1251253245-16616-1-git-send-email-galak@kernel.crashing.org>
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On Aug 25, 2009, at 9:20 PM, Kumar Gala wrote:

> Some of the PCI features we have in ppc32 we will need on ppc64
> platforms in the future.  These include support for:
>
> * ppc_md.pci_exclude_device
> * indirect config cycles
> * early config cycles
>
> We also simplified the logic in fake_pci_bus() to assume it will  
> always
> get a valid pci_controller.  Since all current callers seem to pass it
> one.
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> arch/powerpc/include/asm/machdep.h    |    6 +-
> arch/powerpc/include/asm/pci-bridge.h |   35 +++++++---------
> arch/powerpc/kernel/pci-common.c      |   70 ++++++++++++++++++++++++ 
> ++++++++
> arch/powerpc/kernel/pci_32.c          |   71  
> ---------------------------------
> 4 files changed, 89 insertions(+), 93 deletions(-)

Ben, Grant

This should just be a refresh of the patch mentioned here:

http://patchwork.ozlabs.org/patch/26648/

with the commit message cleaned up and rebased on 'next'.

- k
