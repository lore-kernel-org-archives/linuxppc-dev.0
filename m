Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 6FE09B6F83
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2011 07:20:27 +1100 (EST)
Message-ID: <1322684407.29041.1.camel@pasglop>
Subject: Re: [PATCH 3/6] 44x: Removing dead CONFIG_PPC47x
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Josh Boyer <jwboyer@gmail.com>
Date: Thu, 01 Dec 2011 07:20:07 +1100
In-Reply-To: <CA+5PVA637ckfo60Foc_G_yhuJg6=fbuyQcjFDwYV_XFLkd6whA@mail.gmail.com>
References: <1322630640-13708-1-git-send-email-tony@bakeyournoodle.com>
 <1322630640-13708-4-git-send-email-tony@bakeyournoodle.com>
 <CA+5PVA637ckfo60Foc_G_yhuJg6=fbuyQcjFDwYV_XFLkd6whA@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Christoph Egger <siccegge@cs.fau.de>,
 LinuxPPC-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-11-30 at 06:43 -0500, Josh Boyer wrote:
> 
> That doesn't look right.  The code is there doing something, why is it
> just being removed?  I would think the change would be to use
> CONFIG_PPC_47x?
> 
> Or if the code there isn't needed any longer, the changelog should say
> why.

Ah right, I tripped on this one too when reviewing then figured it out
but I agree, the changelog should be clearer.

If you notice, the original ifdef was in a function that is only ever
used on 44x. There's a separate function that handles 47x. I suppose
this is a leftover of the initial port which somebody forgot to remove.

So the patch is fine, but yes, the changelog could be made clearer.

Cheers,
Ben.
