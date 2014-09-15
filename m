Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 745C11A0020
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 15 Sep 2014 13:00:48 +1000 (EST)
Message-ID: <1410750047.24738.7.camel@concordia>
Subject: Re: [PATCH] powerpc: Add macros for the ibm_architecture_vec[] lengths
From: Michael Ellerman <mpe@ellerman.id.au>
To: Stewart Smith <stewart@linux.vnet.ibm.com>
Date: Mon, 15 Sep 2014 13:00:47 +1000
In-Reply-To: <m3a969sj08.fsf@oc8180480414.ibm.com>
References: <1409295703-31174-1-git-send-email-mpe@ellerman.id.au>
 <m3a969sj08.fsf@oc8180480414.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-09-09 at 11:03 +1000, Stewart Smith wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > The encoding of the lengths in the ibm_architecture_vec array is
> > "interesting" to say the least. It's non-obvious how the number of bytes
> > we provide relates to the length value.
> >
> > In fact we already got it wrong once, see 11e9ed43ca8a "Fix up
> > ibm_architecture_vec definition".
> >
> > So add some macros to make it (hopefully) clearer. These at least have
> > the property that the integer present in the code is equal to the number
> > of bytes that follows it.
> >
> > Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
> 
> Seems at least as correct as the code was before... so,
> 
> Reviewed-by: Stewart Smith <stewart@linux.vnet.ibm.com>
> 
> (not actually compiled or tested or anything, but my internal C
> preprocesser says it looks okay :)

Thanks for the review, it's one of those patches it would be easy to get wrong
because it's so simple in theory.

As a test I deliberately broke the NUM_VECTORS value, and .. my system booted
just fine! So I think I'll give this a bit more scrutiny and work out what's
going on there first :)

cheers
