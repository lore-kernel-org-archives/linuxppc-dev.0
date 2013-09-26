Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 126212C0094
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 08:01:07 +1000 (EST)
Message-ID: <1380232830.28561.71.camel@pasglop>
Subject: Re: [PATCH] hvc_vio: Do not override preferred console set by
 kernel parameter
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Date: Fri, 27 Sep 2013 08:00:30 +1000
In-Reply-To: <20130926212254.GA12564@kroah.com>
References: <1378052656.25743.33.camel@deadeye.wl.decadent.org.uk>
 <1378079740.3978.13.camel@pasglop> <20130926212254.GA12564@kroah.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Bastian Blank <waldi@debian.org>, Jiri Slaby <jslaby@suse.cz>,
 Ben Hutchings <ben@decadent.org.uk>, linuxppc-dev@lists.ozlabs.org,
 Debian kernel maintainers <debian-kernel@lists.debian.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-09-26 at 14:22 -0700, Greg Kroah-Hartman wrote:

> So, I shouldn't apply this patch?  We should do something to fix this,
> if Debian has to drag this patch on for 5 years, that's an indication
> that this might be one solution we should use, right?

Ah sorry, dropped the ball on that one. Yes the patch is an acceptable
band-aid but somebody should work on a better solution :-)

Cheers,
Ben.
