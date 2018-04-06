Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40HQrv6FBlzF1vP
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 13:57:51 +1000 (AEST)
Message-ID: <1522987056.21446.226.camel@kernel.crashing.org>
Subject: Re: [RESEND v2 3/4] doc/devicetree: Persistent memory region bindings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dan Williams <dan.j.williams@intel.com>, Oliver <oohall@gmail.com>
Cc: linux-nvdimm <linux-nvdimm@lists.01.org>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, Device Tree <devicetree@vger.kernel.org>
Date: Fri, 06 Apr 2018 13:57:36 +1000
In-Reply-To: <CAPcyv4gv0rVQ+TTV=omcAO7tA5orufBadQn9ugK1jYwGH_NT=g@mail.gmail.com>
References: <20180403142415.30083-1-oohall@gmail.com>
 <20180403142415.30083-3-oohall@gmail.com>
 <CAPcyv4jW5H8A96MFD7-UazNSZq-t1_NfrChNB3p9=somdBpsNw@mail.gmail.com>
 <20180404220750.0436bbe1@gmail.com>
 <CAOSf1CGdKU4zQQauqo3UoNvKnKDMHteAEtsMWVtTG7T01csMbg@mail.gmail.com>
 <CAPcyv4if4un9mgFon4ttjKDYEtHC_GP6VoxUENp7YNS50T3afA@mail.gmail.com>
 <CAOSf1CHu4R-t8q-8fL6Dyk7myFR0gTfd6-0cxqtBVGZgYZWGAw@mail.gmail.com>
 <87bmexua3s.fsf@concordia.ellerman.id.au>
 <CAOSf1CEUnucUhW_pXG=7h5QBHvaH2-ENPKjGD42_0WEvbU6-Wg@mail.gmail.com>
 <CAPcyv4jEFMnYqpcop=Ox-dZR3dSBRMhT05JSS-gPABX_YQGw1g@mail.gmail.com>
 <CAOSf1CGtNg4_siQtAw-H95Ay1m7YPvjZeqnmWvELb1xH1stRJQ@mail.gmail.com>
 <CAPcyv4gv0rVQ+TTV=omcAO7tA5orufBadQn9ugK1jYwGH_NT=g@mail.gmail.com>
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

On Thu, 2018-04-05 at 19:25 -0700, Dan Williams wrote:
> > > Please also include my niggly nit picky trivial annoying bike shed
> > > color for the driver name to *not* use the "nd_region" suffix for a
> > > driver registering "nvdimm_bus" objects. "of_pmem_range" or
> > > "of_pmem_bus" or almost anything else would be fine.
> > 
> > Oh sure, would using of_pmem_region to match the compatible be ok?
> 
> That works for me.

The prefix "of" is not generally used in matching properties,...

my own pot of paint :)

Cheers,
Ben.
