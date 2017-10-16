Return-Path: <joe@perches.com>
Received: from smtprelay.hostedemail.com (smtprelay0210.hostedemail.com
 [216.40.44.210])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yGD2p4gCTzDrF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Oct 2017 09:46:41 +1100 (AEDT)
Message-ID: <1508193989.6530.17.camel@perches.com>
Subject: Re: [PATCH 0/4] char-TPM: Adjustments for ten function implementations
From: Joe Perches <joe@perches.com>
To: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>, SF Markus Elfring
 <elfring@users.sourceforge.net>
Cc: linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>,  Corentin Labbe <clabbe.montjoie@gmail.com>,
 Jason Gunthorpe <jgunthorpe@obsidianresearch.com>, Jerry Snitselaar
 <jsnitsel@redhat.com>, Kenneth Goldman <kgold@linux.vnet.ibm.com>, Michael
 Ellerman <mpe@ellerman.id.au>, Nayna Jain <nayna@linux.vnet.ibm.com>, Paul
 Mackerras <paulus@samba.org>, Peter =?ISO-8859-1?Q?H=FCwe?=
 <PeterHuewe@gmx.de>,  Stefan Berger <stefanb@linux.vnet.ibm.com>, LKML
 <linux-kernel@vger.kernel.org>,  kernel-janitors@vger.kernel.org
Date: Mon, 16 Oct 2017 15:46:29 -0700
In-Reply-To: <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
References: <1d3516a2-a8e6-9e95-d438-f115fac84c7f@users.sourceforge.net>
 <20171016183139.otyh3m5c5yurtmow@linux.intel.com>
 <20171016183512.3bz6x4b6lbhpbkje@linux.intel.com>
Content-Type: text/plain; charset="ISO-8859-1"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2017-10-16 at 21:35 +0300, Jarkko Sakkinen wrote:
> A minor complaint: all commits are missing "Fixes:" tag.

None of these patches fix anything.
All are trivial changes without much of any impact.
