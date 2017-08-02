Return-Path: <jarkko.sakkinen@linux.intel.com>
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xMtH55Js7zDrHB
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Aug 2017 22:46:41 +1000 (AEST)
Date: Wed, 2 Aug 2017 15:36:19 +0300
From: Jarkko Sakkinen <jarkko.sakkinen@linux.intel.com>
To: SZ Lin <sz.lin@moxa.com>
Cc: ashleydlai@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, peterhuewe@gmx.de, tpmdd@selhorst.ne,
 jgunthorpe@obsidianresearch.com, tpmdd-devel@lists.sourceforge.net,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/5] tpm: tpm_ibmvtpm: - style fix
Message-ID: <20170802123619.nhmwexzaybck3lif@linux.intel.com>
References: <20170729072433.13194-1-sz.lin@moxa.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170729072433.13194-1-sz.lin@moxa.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Jul 29, 2017 at 03:24:28PM +0800, SZ Lin wrote:
> Fix styling WARNINGs and Errors of tpm_ibmvtpm.c driver by using checkpatch.pl

Changes are great but you should revise the patch series so that you
expain in each commit what goes wrong instead of copy paste of the
checkpatch output and why your changes fixes the problem.

> 
> SZ Lin (5):
>   Fix packed and aligned attribute warnings.
>   Fix "ERROR: code indent should use tabs where possible"
>   Fix 'void function return statements are not generally useful' warning
>   Remove unneccessary 'out of memory' message
>   Use __func__ instead of function name
> 
>  drivers/char/tpm/tpm_ibmvtpm.c | 23 +++++++++--------------
>  drivers/char/tpm/tpm_ibmvtpm.h |  2 +-
>  2 files changed, 10 insertions(+), 15 deletions(-)
> 
> --
> 2.13.3
> 

/Jarkko
