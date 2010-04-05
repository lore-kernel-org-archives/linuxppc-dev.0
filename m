Return-Path: <lethal@linux-sh.org>
Received: from master.linux-sh.org (124x34x33x190.ap124.ftth.ucom.ne.jp
	[124.34.33.190]) by ozlabs.org (Postfix) with ESMTP id EB3C9B7D15
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Apr 2010 07:48:00 +1000 (EST)
Date: Tue, 6 Apr 2010 06:46:27 +0900
From: Paul Mundt <lethal@linux-sh.org>
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 1/4] panic: Allow warnings to set different taint flags
Message-ID: <20100405214626.GA25192@linux-sh.org>
References: <1270319696.12516.321.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1270319696.12516.321.camel@localhost>
Cc: linux-s390@vger.kernel.org, linux-parisc@vger.kernel.org,
	linux-sh@vger.kernel.org, linux-pci@vger.kernel.org,
	LKML <linux-kernel@vger.kernel.org>,
	Jesse Barnes <jbarnes@virtuousgeek.org>, linuxppc-dev@ozlabs.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Apr 03, 2010 at 07:34:56PM +0100, Ben Hutchings wrote:
> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the flag for TAINT_WARN.  To allow for this,
> add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint number
> as argument.
> 
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() now implement __WARN_TAINT(taint)
> instead of __WARN().
> 
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> ---
> Changes since the previous version:
> - Added note to Documentation/oops-tracing.txt
> - Changed the commit message to distinguish taint numbers from taint
>   flags
> - Removed 'must' from last sentence of commit message; this patch
>   converts all mainline architectures
> 
This seems to be missing my Tested-by from the last iteration, since
there are no functional changes with this version feel free to add it in
again.
