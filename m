Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xhJjn2LqTzDrVR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Aug 2017 16:33:17 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org
Cc: martin.petersen@oracle.com, linuxppc-dev@lists.ozlabs.org,
 "Bryant G. Ly" <bryantly@linux.vnet.ibm.com>, "Bryant G. Ly" <bgly@us.ibm.com>
Subject: Re: [PATCH] powerpc/kernel: Change retrieval of pci_dn
In-Reply-To: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
References: <1503936303-18274-1-git-send-email-bryantly@linux.vnet.ibm.com>
Date: Tue, 29 Aug 2017 16:33:17 +1000
Message-ID: <87tw0q289e.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

"Bryant G. Ly" <bryantly@linux.vnet.ibm.com> writes:

> For a PCI device it's pci_dn can be retrieved from
> pdev->dev.archdata.firmware_data, PCI_DN(devnode), or parent's list.
> Thus, we should just use the generic function pci_get_pdn_by_devfn
> to get the pci_dn.
>
> Signed-off-by: Bryant G. Ly <bgly@us.ibm.com>

Minor issue, it's preferable if the email in your Signed-off-by matches
the email you send patches from.

cheers
