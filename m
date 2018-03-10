Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zzFCN1w5VzF1Vv
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 11 Mar 2018 06:47:43 +1100 (AEDT)
Date: Sat, 10 Mar 2018 11:47:42 -0800
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: christophe leroy <christophe.leroy@c-s.fr>
Cc: stable@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 4.14 1/4] powerpc/mm/slice: Remove intermediate bitmap copy
Message-ID: <20180310194742.GA12279@kroah.com>
References: <69684e92a32d00c491540e8adfa34fcb50c36244.1520468013.git.christophe.leroy@c-s.fr>
 <20180310001043.GD13963@kroah.com>
 <39af0017-6a9c-a032-8167-40b5f30840f8@c-s.fr>
 <20180310145258.GA6874@kroah.com>
 <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <84cf5fef-a940-cb2a-431e-5a550f725c4f@c-s.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, Mar 10, 2018 at 05:14:22PM +0100, christophe leroy wrote:
> 
> 
> Le 10/03/2018 à 15:52, Greg Kroah-Hartman a écrit :
> > On Sat, Mar 10, 2018 at 08:27:54AM +0100, christophe leroy wrote:
> > > 
> > > 
> > > Le 10/03/2018 à 01:10, Greg Kroah-Hartman a écrit :
> > > > On Fri, Mar 09, 2018 at 04:48:59PM +0100, Christophe Leroy wrote:
> > > > > Upstream 326691ad4f179e6edc7eb1271e618dd673e4736d
> > > > 
> > > > There is no such git commit id in Linus's tree :(
> > > > 
> > > > Please fix up and resend the series.
> > > 
> > > I checked again, it is there
> > > 
> > > https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/arch/powerpc/mm/slice.c?h=next-20180309&id=326691ad4f179e6edc7eb1271e618dd673e4736d
> > 
> > That is linux-next, which has everything and the kitchen sink.  It is
> > not Linus's tree.  Please wait for these things to be merged into
> > Linus's tree before asking for the to be merged into the stable tree.
> > That's a requirement.
> > 
> 
> Oops, sorry, I thought everything on kernel.org was official.

That would be a whole lot of "official" :)

Please read:
    https://www.kernel.org/doc/html/latest/process/stable-kernel-rules.html
for what the rules are here, if you haven't already.

> Once it is in, do I resend the patches or do I just ping you ?

You would need to resend the patches (if they need backporting
manually), or just send a list of the git commit ids that are needed to
be applied (usually easier.)

Also, why were these patches not tagged with the stable tag to start
with?  That way they would be automatically included in the stable tree
when they hit Linus's tree.

thanks,

greg k-h
