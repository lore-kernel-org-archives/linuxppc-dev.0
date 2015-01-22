Return-Path: <cascardo@linux.vnet.ibm.com>
Received: from e24smtp04.br.ibm.com (e24smtp04.br.ibm.com [32.104.18.25])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5A5071A0E6F
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 21:56:01 +1100 (AEDT)
Received: from /spool/local
 by e24smtp04.br.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <cascardo@linux.vnet.ibm.com>;
 Thu, 22 Jan 2015 08:55:58 -0200
Received: from d24relay01.br.ibm.com (d24relay01.br.ibm.com [9.8.31.16])
 by d24dlp01.br.ibm.com (Postfix) with ESMTP id D60033520062
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 05:54:56 -0500 (EST)
Received: from d24av04.br.ibm.com (d24av04.br.ibm.com [9.8.31.97])
 by d24relay01.br.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0MAu4Bx4759776
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 08:56:05 -0200
Received: from d24av04.br.ibm.com (localhost [127.0.0.1])
 by d24av04.br.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0MAtqJ1021467
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Jan 2015 08:55:52 -0200
Date: Thu, 22 Jan 2015 08:54:33 -0200
From: cascardo@linux.vnet.ibm.com
To: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH resend] powernv/iommu: disable IOMMU bypass with param
 iommu=nobypass
Message-ID: <20150122105433.GA12440@oc0812247204.ltc.br.ibm.com>
References: <1421853832-32533-1-git-send-email-cascardo@linux.vnet.ibm.com>
 <1421888731.4598.1.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1421888731.4598.1.camel@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-doc@vger.kernel.org, paulus@samba.org,
 gwshan@linux.vnet.ibm.com, corbet@lwn.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 22, 2015 at 12:05:31PM +1100, Michael Ellerman wrote:
> On Wed, 2015-01-21 at 13:23 -0200, Thadeu Lima de Souza Cascardo wrote:
> > When IOMMU bypass is enabled, a PCI device can read and write memory
> > that was not mapped by the driver without causing an EEH. That might
> > cause memory corruption, for example.
> > 
> > When we disable bypass, DMA reads and writes to addresses not mapped by
> > the IOMMU will cause an EEH, allowing us to debug such issues.
> > 
> > Signed-off-by: Thadeu Lima de Souza Cascardo <cascardo@linux.vnet.ibm.com>
> > Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> > ---
> >  Documentation/kernel-parameters.txt       |    2 ++
> >  arch/powerpc/platforms/powernv/pci-ioda.c |   24 +++++++++++++++++++++++-
> >  2 files changed, 25 insertions(+), 1 deletion(-)
> 
> Is this unchanged since v2?
> 

Yes, it's unchanged, just rebased.

Cascardo.

> It's marked as under review in patchwork which means I'm looking at it:
> 
>   http://patchwork.ozlabs.org/patch/402682/
> 
> 
> Please check patchwork in future.
> 
> cheers
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
