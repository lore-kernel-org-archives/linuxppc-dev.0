Return-Path: <srs0=wy6n=im=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40skTs0WztzF1fC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:26:25 +1000 (AEST)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 40skTs01r1z8tKh
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 25 May 2018 21:26:25 +1000 (AEST)
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 40skTq2vbFz9s1b
 for <linuxppc-dev@ozlabs.org>; Fri, 25 May 2018 21:26:22 +1000 (AEST)
Date: Fri, 25 May 2018 13:26:01 +0200
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, tglx@linutronix.de, linuxppc-dev@ozlabs.org
Subject: Re: [PATCH stable 4.14 00/23] powerpc backports for 4.14
Message-ID: <20180525112601.GA348@kroah.com>
References: <20180525100954.31599-1-mpe@ellerman.id.au>
 <87bmd4q9ow.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87bmd4q9ow.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, May 25, 2018 at 09:03:11PM +1000, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Hi Greg,
> >
> > Please queue up this series of patches for 4.14 if you have no objections.
> 
> I just realised I didn't fix up the cherry-pick markings on these, so
> they still say eg:
> 
>   (cherry picked from commit bdcb1aefc5b3f7d0f1dc8b02673602bca2ff7a4b)
> 
> Not the proper "commit bdcb1... upstream" style.
> 
> I'll hold off resending in case you have some sed magic to fix that, but
> let me know if you'd like me to do it and resend the series.

I don't have any sed magic for that, sorry.  Can you fix up and resend?

thanks,

greg k-h
