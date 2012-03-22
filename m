Return-Path: <linus971@gmail.com>
Received: from mail-wi0-f170.google.com (mail-wi0-f170.google.com
 [209.85.212.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 244CBB6EE7
 for <linuxppc-dev@ozlabs.org>; Thu, 22 Mar 2012 13:02:23 +1100 (EST)
Received: by wibhr17 with SMTP id hr17so174905wib.3
 for <linuxppc-dev@ozlabs.org>; Wed, 21 Mar 2012 19:02:20 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1332377206.2982.60.camel@pasglop>
References: <1332377206.2982.60.camel@pasglop>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Wed, 21 Mar 2012 19:02:00 -0700
Message-ID: <CA+55aFz-pyBHa73zkbkub4czwnU+k4_qKzBEaAGvi66MBBUTpQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git next branch
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Grant Likely <grant.likely@secretlab.ca>,
 Kyle Moffett <Kyle.D.Moffett@boeing.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Russell King <linux@arm.linux.org.uk>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Mar 21, 2012 at 5:46 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Here's the powerpc batch for this merge window. It is going to be a bit
> more nasty than usual as in touching things outside of arch/powerpc
> mostly due to the big iSeriesectomy :-) We finally got rid of the bugger
> (legacy iSeries support) which was a PITA to maintain and that nobody
> really used anymore.
>
> Here are some of the highlights:

Ok, so this conflicted a bit with the generalized irq-domain stuff
from Grant Likely, and while I tried to fix it up I can't even
compile-test the end result, so you really need to verify my merge and
perhaps send me fixups. Ok?

Especially the sysdev/mpic.c resolution needs somebody who knows the
code to verify. Added Grant and Kyle explicitly to the cc..

                      Linus
