Return-Path: <paulus@ozlabs.org>
Date: Wed, 1 Aug 2012 15:18:09 +1000
From: Paul Mackerras <paulus@samba.org>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH -V5 07/13] arch/powerpc: Make some of the PGTABLE_RANGE
 dependency explicit
Message-ID: <20120801051808.GD24014@drongo>
References: <1343647339-25576-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1343647339-25576-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1343647339-25576-8-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jul 30, 2012 at 04:52:13PM +0530, Aneesh Kumar K.V wrote:
> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
> 
> slice array size and slice mask size depend on PGTABLE_RANGE. We
> can't directly include pgtable.h in these header because there is
> a circular dependency. So add compile time check for these values.
> 
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

Reviewed-by: Paul Mackerras <paulus@samba.org>

but you might like to change:

> +#define SLICE_MASK_SIZE (PGTABLE_RANG >> 43)

to have PGTABLE_RANGE rather than PGTABLE_RANG.
