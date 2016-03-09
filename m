Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3221A004B
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  9 Mar 2016 23:51:39 +1100 (AEDT)
In-Reply-To: <1456445640-24085-1-git-send-email-gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc/eeh: Remove duplicated check in eeh_dump_pe_log()
Message-Id: <20160309125139.369E1140BB9@ozlabs.org>
Date: Wed,  9 Mar 2016 23:51:39 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-26-02 at 00:14:00 UTC, Gavin Shan wrote:
> When eeh_dump_pe_log() is only called by eeh_slot_error_detail(),
> we already have the check that the PE isn't in PCI config blocked
> state in eeh_slot_error_detail(). So we needn't the duplicated
> check in eeh_dump_pe_log().
> 
> This removes the duplicated check in eeh_dump_pe_log(). No logical
> changes introduced.
> 
> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> Reviewed-by: Andrew Donnellan <andrew.donnellan@au1.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/b6c7347f2f6176fa3225903fbf

cheers
