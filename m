Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yG6Sq0lrdzDrFv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 05:35:22 +1100 (AEDT)
Date: Mon, 16 Oct 2017 21:35:12 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SF Markus Elfring <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>,
 Jerry Snitselaar <jsnitsel@redhat.com>,
 Kenneth Goldman <kgold@linux.vnet.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Nayna Jain <nayna@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Peter =?iso-8859-1?Q?H=FCwe?= <PeterHuewe@gmx.de>,
 Stefan Berger <stefanb@linux.vnet.ibm.com>,
 LKML <linux-kernel@vger.kernel.org>, kernel-janitors@vger.kernel.org
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
Message-ID: <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 16, 2017 at 09:31:39PM +0300, Jarkko Sakkinen wrote:
> On Mon, Oct 16, 2017 at 07:30:13PM +0200, SF Markus Elfring wrote:
> > From: Markus Elfring <elfring@users.sourceforge.net>
> > Date: Mon, 16 Oct 2017 19:12:34 +0200
> > 
> > A few update suggestions were taken into account
> > from static source code analysis.
> > 
> > Markus Elfring (4):
> >   Delete an error message for a failed memory allocation
> >     in tpm_ascii_bios_measurements_show()
> >   Delete an error message for a failed memory allocation in tpm_ibmvtpm_probe()
> >   Improve a size determination in nine functions
> >   Less checks in tpm_ibmvtpm_probe() after error detection
> > 
> >  drivers/char/tpm/st33zp24/i2c.c      |  3 +--
> >  drivers/char/tpm/st33zp24/spi.c      |  3 +--
> >  drivers/char/tpm/st33zp24/st33zp24.c |  3 +--
> >  drivers/char/tpm/tpm1_eventlog.c     |  5 +----
> >  drivers/char/tpm/tpm_crb.c           |  2 +-
> >  drivers/char/tpm/tpm_i2c_atmel.c     |  2 +-
> >  drivers/char/tpm/tpm_i2c_nuvoton.c   |  2 +-
> >  drivers/char/tpm/tpm_ibmvtpm.c       | 23 +++++++++--------------
> >  drivers/char/tpm/tpm_tis.c           |  2 +-
> >  drivers/char/tpm/tpm_tis_spi.c       |  3 +--
> >  10 files changed, 18 insertions(+), 30 deletions(-)
> > 
> > -- 
> > 2.14.2
> > 
> 
> For some sparse errors I fixed a while ago I got review feedback that
> one should explain what is wrong what the fix does and not tell tool
> reported. And it really does make sense to me.
> 
> Describing the tool that was used to find the issues fits to the cover
> letter but not to the commits themselves.
> 
> I think I recently accepted a small fix with a "tool generated commit
> message" but I don't want to take it as a practice It was a minor
> mistake from my side to accept such patch.

A minor complaint: all commits are missing "Fixes:" tag.

/Jarkko
