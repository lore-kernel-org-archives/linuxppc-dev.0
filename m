Return-Path: <elliott@hpe.com>
Received: from NAM01-SN1-obe.outbound.protection.outlook.com
 (mail-sn1nam01on0102.outbound.protection.outlook.com [104.47.32.102])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vPzL62rlyzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2017 03:41:02 +1100 (AEDT)
From: "Elliott, Robert (Persistent Memory)" <elliott@hpe.com>
To: Jon Derrick <jonathan.derrick@intel.com>, Michael Ellerman
 <mpe@ellerman.id.au>
CC: Jens Axboe <axboe@kernel.dk>, Rafael Antognolli
 <rafael.antognolli@intel.com>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, "linux-kernel@vger.kernel.org"
 <linux-kernel@vger.kernel.org>, "linux-block@vger.kernel.org"
 <linux-block@vger.kernel.org>, "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, Christoph Hellwig <hch@lst.de>, Scott Bauer
 <scott.bauer@intel.com>
Subject: RE: [PATCHv3 4/4] MAINTAINERS: Remove powerpc's opal match
Date: Fri, 17 Feb 2017 16:40:56 +0000
Message-ID: <DF4PR84MB0169EEA591FC3735FA9B0DCDAB5D0@DF4PR84MB0169.NAMPRD84.PROD.OUTLOOK.COM>
References: <1487187731-10293-1-git-send-email-jonathan.derrick@intel.com>
 <1487187731-10293-5-git-send-email-jonathan.derrick@intel.com>
 <87poiik8tb.fsf@concordia.ellerman.id.au>
 <64674df8-8e5e-07a0-8062-d02e588b2a32@intel.com>
In-Reply-To: <64674df8-8e5e-07a0-8062-d02e588b2a32@intel.com>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



> -----Original Message-----
> From: linux-block-owner@vger.kernel.org [mailto:linux-block-
> owner@vger.kernel.org] On Behalf Of Jon Derrick
> Sent: Thursday, February 16, 2017 10:15 AM
> To: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Jens Axboe <axboe@kernel.dk>; Rafael Antognolli
> <rafael.antognolli@intel.com>; Greg Kroah-Hartman
> <gregkh@linuxfoundation.org>; linux-kernel@vger.kernel.org; linux-
> block@vger.kernel.org; linuxppc-dev@lists.ozlabs.org; Christoph Hellwig
> <hch@lst.de>; Scott Bauer <scott.bauer@intel.com>
> Subject: Re: [PATCHv3 4/4] MAINTAINERS: Remove powerpc's opal match
>=20
> Thanks everyone. Sorry about the mess :)
>=20
> On 02/15/2017 10:23 PM, Michael Ellerman wrote:
> > Jon Derrick <jonathan.derrick@intel.com> writes:
> >
> >> PPC's 'opal' match pattern also matches block/sed-opal.c, where it loo=
ks
> >> like the 'arch/powerpc' file pattern should be enough to match powerpc
> >> opal code by itself. Remove the opal regex pattern from powerpc.
> >
> > We thought of it first.
> >
> > Can't you just rename your driver, Opal Storage Specification, so "oss"=
,
> > that should be pretty unique?
> >
> > ... :)

The library could easily be used for devices supporting the Opalite and Pyr=
ite=20
SSCs, not just the Opal SSC. With some effort, I suspect that Enterprise SS=
C
could also be supported.  So, a broader name might indeed be useful.

The full names of the specifications are:
TCG Storage Security Subsystem Class: Opal
TCG Storage Security Subsystem Class: Opalite
TCG Storage Security Subsystem Class: Pyrite
TCG Storage Security Subsystem Class: Enterprise

---
Robert Elliott, HPE Persistent Memory
