Return-Path: <gregkh@suse.de>
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx2.suse.de",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A4F4467C29
	for <linuxppc-dev@ozlabs.org>; Thu, 24 Aug 2006 14:10:38 +1000 (EST)
Date: Wed, 23 Aug 2006 21:10:27 -0700
From: Greg KH <gregkh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: Please pull powerpc.git 'merge' branch
Message-ID: <20060824041027.GA19887@suse.de>
References: <17644.63105.27596.85261@cargo.ozlabs.ibm.com>
	<20060824010508.GA17848@suse.de>
	<17645.9406.384676.189697@cargo.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <17645.9406.384676.189697@cargo.ozlabs.ibm.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Thu, Aug 24, 2006 at 02:02:06PM +1000, Paul Mackerras wrote:
> Greg KH writes:
> 
> > $ git pull  git://git.kernel.org/pub/scm/linux/kernel/git/paulus/powerpc.git merge
> > Already up-to-date.
> > 
> > Perhaps I should be pulling from a different branch?
> 
> No, that's the right branch, but the mirroring was very slow. My
> update of hours ago has only just propagated out.  Try again now.

Ok, that worked.  I can pull from master@kernel.org too, which would
have worked here :)

thanks,

greg k-h
