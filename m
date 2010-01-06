Return-Path: <jkosina@suse.cz>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
	by ozlabs.org (Postfix) with ESMTP id 00D6FB6EF0
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Jan 2010 10:23:29 +1100 (EST)
Date: Thu, 7 Jan 2010 00:23:26 +0100 (CET)
From: Jiri Kosina <jkosina@suse.cz>
To: Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH] Fix spelling in comments and documentation
In-Reply-To: <20100106151144.e58bdd4a.akpm@linux-foundation.org>
Message-ID: <alpine.LNX.2.00.1001070022491.2277@pobox.suse.cz>
References: <1262819032-16644-1-git-send-email-weil@mail.berlios.de>
	<20100106151144.e58bdd4a.akpm@linux-foundation.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stefan Weil <weil@mail.berlios.de>, Greg Kroah-Hartman <gregkh@suse.de>,
	linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
	linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 6 Jan 2010, Andrew Morton wrote:

> > Replace platfrom -> platform.
> > 
> > This is a frequent spelling bug.
> 
> I have a "no spelling fixes unless they're in documentation or printks"
> policy ;)
> 
> trivial@kernel.org would be a suitable recipient for this patch.

Yup, I am usually applying all the comment typo fixes, as it makes the 
source more grepping-friendly.

Applied, thanks Stefan.

-- 
Jiri Kosina
SUSE Labs, Novell Inc.
