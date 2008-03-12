Return-Path: <tytso@mit.edu>
Received: from thunker.thunk.org (www.church-of-our-saviour.org [69.25.196.31])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 7DFFDDDEEC
	for <linuxppc-dev@ozlabs.org>; Thu, 13 Mar 2008 01:43:16 +1100 (EST)
Date: Wed, 12 Mar 2008 10:42:39 -0400
From: Theodore Tso <tytso@mit.edu>
To: Tony Breeds <tony@bakeyournoodle.com>
Subject: Re: [PATCH] ppc: Export empty_zero_page
Message-ID: <20080312144239.GY15804@mit.edu>
References: <E1JZGwo-0000vf-2v@closure.thunk.org>
	<20080312034110.GT6887@bakeyournoodle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20080312034110.GT6887@bakeyournoodle.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, Mar 12, 2008 at 02:41:10PM +1100, Tony Breeds wrote:
> 
> I suspect you meant arch/*powerpc* arch ppc, wont fix the problem ;P
> 

Um, right.  I didn't know about this:

> Why:  The arch/powerpc tree is the merged architecture for ppc32 and ppc64
>      platforms.  Currently there are efforts underway to port the remaining
>      arch/ppc platforms to the merged tree.  New submissions to the arch/ppc
>      tree have been frozen with the 2.6.22 kernel release and that tree will
>      remain in bug-fix only mode until its scheduled removal.  Platforms
>      that are not ported by June 2008 will be removed due to the lack of an
>      interested maintainer. 

Oops, sorry.  So should I not bother with a patch to arch/ppc at all?
I guess it's somewhat likely that whatever is left in arch/ppc is not
likely to need to support ext4?

Back with a real patch in just a bit.  :-)

						- Ted
