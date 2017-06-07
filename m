Return-Path: <gregkh@linuxfoundation.org>
Received: from mail.linuxfoundation.org (mail.linuxfoundation.org
 [140.211.169.12])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wjNDm19pLzDqKm
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Jun 2017 19:15:03 +1000 (AEST)
Date: Wed, 7 Jun 2017 11:14:54 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH] driver core: remove CLASS_ATTR usage
Message-ID: <20170607091454.GA6559@kroah.com>
References: <20170606133203.GA7518@kroah.com>
 <87k24opocj.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87k24opocj.fsf@concordia.ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 07, 2017 at 11:40:12AM +1000, Michael Ellerman wrote:
> Greg KH <gregkh@linuxfoundation.org> writes:
> 
> > From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> >
> > There was only 2 remaining users of CLASS_ATTR() so let's finally get
> > rid of them and force everyone to use the correct RW/RO/WO versions
> > instead.
> >
> > Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> > Cc: Paul Mackerras <paulus@samba.org>
> > Cc: Michael Ellerman <mpe@ellerman.id.au>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > ---
> >
> > PPC maintainers, can I take this in my driver core tree?  I'm doing some
> > cleanups of device.h and this was one of the simpler ones at the moment.
> 
> Yeah looks good to me, I did a quick build test and it was OK.
> 
> Acked-by: Michael Ellerman <mpe@ellerman.id.au>

Wonderful, thanks for testing it out.

greg k-h
