Return-Path: <dan.carpenter@oracle.com>
Received: from userp1050.oracle.com (userp1050.oracle.com [156.151.31.82])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGVg14gQPzDqlv
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 20:45:33 +1100 (AEDT)
Received: from userp1040.oracle.com (userp1040.oracle.com [156.151.31.81])
 by userp1050.oracle.com (Sentrion-MTA-4.3.2/Sentrion-MTA-4.3.2) with ESMTP id
 v9H9jStg009793
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 09:45:29 GMT
Date: Tue, 17 Oct 2017 12:44:34 +0300
From: Dan Carpenter <dan.carpenter@oracle.com>
To: Julia Lawall <julia.lawall@lip6.fr>
Cc: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>,
 SF Markus Elfring <elfring@users.sourceforge.net>,
 linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
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
Message-ID: <20171017094434.csarc5fw5d32u64w@mwanda>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
 <20171017085124.pkrjzghcf5wmcydc@mwanda>
 <alpine.DEB.2.20.1710171055100.5035@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <alpine.DEB.2.20.1710171055100.5035@hadrien>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 17, 2017 at 10:56:42AM +0200, Julia Lawall wrote:
> 
> 
> On Tue, 17 Oct 2017, Dan Carpenter wrote:
> 
> > On Mon, Oct 16, 2017 at 09:35:12PM +0300, Jarkko Sakkinen wrote:
> > >
> > > A minor complaint: all commits are missing "Fixes:" tag.
> > >
> >
> > Fixes is only for bug fixes.  These don't fix any bugs.
> 
> 0-day seems to put Fixes for everything.  Should they be removed when the
> old code is undesirable but doesn't actually cause a crash, eg out of date
> API.

Yeah, I feel like Fixes tags don't belong for API updates and cleanups.

regards,
dan carpenter
