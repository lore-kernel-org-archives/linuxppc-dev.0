Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A82131A0742
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Oct 2015 20:32:35 +1100 (AEDT)
Message-ID: <1445247154.30407.3.camel@ellerman.id.au>
Subject: Re: [PATCH] powerpc/prom: Avoid reference to potentially freed memory
From: Michael Ellerman <mpe@ellerman.id.au>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@ozlabs.org
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Date: Mon, 19 Oct 2015 20:32:34 +1100
In-Reply-To: <mvrlh7$mjr$1@ger.gmane.org>
References: <1444976055-19148-1-git-send-email-christophe.jaillet@wanadoo.fr>
 <1444989750.12954.4.camel@ellerman.id.au> <mvrlh7$mjr$1@ger.gmane.org>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2015-10-16 at 22:09 +0200, Christophe JAILLET wrote:

> Le 16/10/2015 12:02, Michael Ellerman a écrit :

> > As the kbuild robot detected you have left an extra "}" here.
> > 
> > I don't mind too much if you send patches that aren't compile tested, but you
> > might save yourself some time by compiling them.
> 
> Sorry about it, and thanks for your patience.
> IMHO, this should never happen and patches should be at least 
> compile-tested.

Preferably yes. But for these sort of cleanup patches, where you're touching
lots of different arches, I realise it can be tedious to find all the various
cross compilers. So I'm willing to cut you a bit of slack :)

> I will be more careful and compile-test any new patch I submit.

Thanks.

cheers
