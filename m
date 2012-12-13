Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 4E72C2C0095
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 13 Dec 2012 13:29:39 +1100 (EST)
Message-ID: <1355365763.19932.75.camel@pasglop>
Subject: Re: [PATCH] vfio powerpc: enabled on powernv platform
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Date: Thu, 13 Dec 2012 13:29:23 +1100
In-Reply-To: <1355322875.3224.201.camel@bling.home>
References: <1354636299.1809.431.camel@bling.home>
 <1354865750-8104-1-git-send-email-aik@ozlabs.ru>
 <1354901926.3224.96.camel@bling.home> <50C820AF.8050804@ozlabs.ru>
 <1355322875.3224.201.camel@bling.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 linuxppc-dev@lists.ozlabs.org, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2012-12-12 at 07:34 -0700, Alex Williamson wrote:
> > But what would I put there?... IOMMU ID is more than enough at the moment 
> > and struct iommu_table does not have anything what would have made sense to 
> > show in the sysfs...
> 
> I believe David mentioned that PEs had user visible names.  Perhaps they
> match an enclosure location or something.  Group numbers are rather
> arbitrary and really have no guarantee of persistence.  Thanks, 

I agree. Make up something, for example domain[PE] or something like
that.

Cheers,
Ben.
