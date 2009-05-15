Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A0EFBDE0AA
	for <linuxppc-dev@ozlabs.org>; Fri, 15 May 2009 22:50:32 +1000 (EST)
Message-Id: <8530F7E1-6EA9-4DA3-9130-DDA1C6E4B510@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <1242391640-18826-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v2] powerpc/pci: clean up direct access to sysdata by
	iseries platform
Date: Fri, 15 May 2009 07:50:22 -0500
References: <1242391640-18826-1-git-send-email-galak@kernel.crashing.org>
Cc: Linuxppc-dev Development <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On May 15, 2009, at 7:47 AM, Kumar Gala wrote:

> We shouldn't directly access sysdata to get the device node.  We  
> should
> be calling pci_device_to_OF_node().
>
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> * Updated based on sfr's iseries pci fix patch
>
> arch/powerpc/platforms/iseries/iommu.c |    2 +-
> arch/powerpc/platforms/iseries/pci.c   |    8 ++++----
> 2 files changed, 5 insertions(+), 5 deletions(-)

Stephen if you can test this version that would be great.

thanks

- k
