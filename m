Return-Path: <akpm@linux-foundation.org>
Received: from smtp1.linux-foundation.org (smtp1.linux-foundation.org
	[140.211.169.13])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "smtp.linux-foundation.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 22F53B7CE7
	for <linuxppc-dev@ozlabs.org>; Tue, 23 Mar 2010 16:48:46 +1100 (EST)
Date: Mon, 22 Mar 2010 22:47:33 -0400
From: Andrew Morton <akpm@linux-foundation.org>
To: Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH 2/4] panic: Allow taint flag for warnings to be changed
	from TAINT_WARN
Message-Id: <20100322224733.9cf93a0a.akpm@linux-foundation.org>
In-Reply-To: <1269126340.18314.115.camel@localhost>
References: <1269126097.18314.111.camel@localhost>
	<1269126340.18314.115.camel@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Sat, 20 Mar 2010 23:05:40 +0000 Ben Hutchings <ben@decadent.org.uk> wrote:

> WARN() is used in some places to report firmware or hardware bugs that
> are then worked-around.  These bugs do not affect the stability of the
> kernel and should not set the usual TAINT_WARN flag.  To allow for
> this, add WARN_TAINT() and WARN_TAINT_ONCE() macros that take a taint
> flag as argument.
> 
> Architectures that implement warnings using trap instructions instead
> of calls to warn_slowpath_*() must now implement __WARN_TAINT(taint)
> instead of __WARN().

When you say they "must now implement", I assume that you mean that
they _do_ now implement, and that no additional architecture work is
needed.

> The architecture-specific changes here are untested and need to be
> reviewed by architecture maintainers.

That would be nice.
