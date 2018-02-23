Return-Path: <srs0=uzl3=fr=kroah.com=greg@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3znrqg4NJFzF1bM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:58:07 +1100 (AEDT)
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 by bilbo.ozlabs.org (Postfix) with ESMTP id 3znrqg2xdyz8wN0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:58:07 +1100 (AEDT)
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com
 [66.111.4.26])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3znrqf1BFDz9s0W
 for <linuxppc-dev@ozlabs.org>; Fri, 23 Feb 2018 23:58:05 +1100 (AEDT)
Date: Fri, 23 Feb 2018 13:58:05 +0100
From: Greg KH <greg@kroah.com>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: stable@vger.kernel.org, npiggin@gmail.com, linuxppc-dev@ozlabs.org,
 linux@roeck-us.net, corsac@debian.org
Subject: Re: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro
 conversions
Message-ID: <20180223125805.GA23233@kroah.com>
References: <20180222065738.GB2428@kroah.com>
 <20180222123545.8946-1-mpe@ellerman.id.au>
 <20180222123545.8946-2-mpe@ellerman.id.au>
 <87606nq527.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87606nq527.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 23, 2018 at 11:11:12PM +1100, Michael Ellerman wrote:
> Michael Ellerman <mpe@ellerman.id.au> writes:
> > Subject: [PATCH v4.4 backport 2/3] powerpc/64s: Simple RFI macro conversions
>                      ^
>                    4.9
> 
> Gah, sorry just realised these last two have "v4.4" in the subject, but
> it should be "4.9".

Ah, good, I was wondering about that :)

I'll apply these after lunch...

greg k-h
