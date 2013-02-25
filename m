Return-Path: <paulus@ozlabs.org>
Date: Mon, 25 Feb 2013 13:21:46 +1100
From: Paul Mackerras <paulus@samba.org>
To: Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH 1/2] vfio powerpc: enabled on powernv platform
Message-ID: <20130225022146.GC12404@drongo>
References: <1360583672-21924-1-git-send-email-aik@ozlabs.ru>
 <1360583672-21924-2-git-send-email-aik@ozlabs.ru>
 <1360621003.12392.117.camel@bling.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1360621003.12392.117.camel@bling.home>
Cc: kvm@vger.kernel.org, Alexey Kardashevskiy <aik@ozlabs.ru>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 11, 2013 at 03:16:43PM -0700, Alex Williamson wrote:
> 
> Why do these all return long (vs int)?  Is this a POWER-ism?

On ppc64 the compiler tends to generate slightly shorter code with
longs than with ints.  The reason is that with ints the compiler has
to put in "extend sign word" instructions to convert 64-bit values
from arithmetic instructions to values in the 32-bit range.

Paul.
