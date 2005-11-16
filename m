Return-Path: <hch@lst.de>
Date: Wed, 16 Nov 2005 09:24:56 +0100
From: Christoph Hellwig <hch@lst.de>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <20051116082456.GA24802@lst.de>
References: <17274.51251.591579.8751@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17274.51251.591579.8751@cargo.ozlabs.ibm.com>
Cc: akpm@osdl.org, linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: Re: powerpc.git tree now on kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Nov 16, 2005 at 04:48:35PM +1100, Paul Mackerras wrote:
> Although some of these patches may go to Linus before 2.6.15 is
> released, I won't be asking Linus to pull this tree directly, since it
> is likely to get a bit messy as patches are updated.  I expect that
> Andrew Morton will pull this tree periodically and include it in his
> -mm releases.

Please make sure at least all patches required to kill arch/ppc64 and
include/asm-ppc64 go to Linus.  If 2.6.15 released with the include3
hack that would mean endless pain to people building external modules
and the distributions trying to support that.
