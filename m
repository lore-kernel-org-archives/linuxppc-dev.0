Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4123wP0yxzzF327
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jun 2018 10:59:48 +1000 (AEST)
Message-ID: <f6fbd7996a2edfc0bdb8363cb6384caeae7d47b9.camel@kernel.crashing.org>
Subject: Re: [RFC PATCH kernel 0/5] powerpc/P9/vfio: Pass through NVIDIA
 Tesla V100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Alex Williamson <alex.williamson@redhat.com>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>, kvm-ppc@vger.kernel.org, Ram
 Pai <linuxram@us.ibm.com>, kvm@vger.kernel.org, Alistair Popple
 <alistair@popple.id.au>
Date: Fri, 08 Jun 2018 10:58:54 +1000
In-Reply-To: <20180607183417.3ff2acf1@w520.home>
References: <20180607084420.29513-1-aik@ozlabs.ru>
 <20180607110409.5057ebac@w520.home>
 <e35a7bbea8b82c17f93eb6eb438df38a94097f2d.camel@kernel.crashing.org>
 <20180607161541.21df6434@w520.home>
 <33590885d138195c8ede78b588ddb03b132267fd.camel@kernel.crashing.org>
 <20180607183417.3ff2acf1@w520.home>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2018-06-07 at 18:34 -0600, Alex Williamson wrote:
> > We *can* allow individual GPUs to be passed through, either if somebody
> > designs a system without cross links, or if the user is ok with the
> > security risk as the guest driver will not enable them if it doesn't
> > "find" both sides of them.
> 
> If GPUs are not isolated and we cannot prevent them from probing each
> other via these links, then I think we have an obligation to configure
> grouping in a way that doesn't rely on a benevolent userspace.  Thanks,

Well, it's a user decision, no ? Like how we used to let the user
decide whether to pass-through things that have LSIs shared out of
their domain.

Cheers,
Ben.
