Return-Path: <linus971@gmail.com>
Received: from mail-we0-f170.google.com (mail-we0-f170.google.com
 [74.125.82.170])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id E04C3B6FBD
 for <linuxppc-dev@ozlabs.org>; Sat,  9 Jun 2012 04:12:14 +1000 (EST)
Received: by werm13 with SMTP id m13so763412wer.15
 for <linuxppc-dev@ozlabs.org>; Fri, 08 Jun 2012 11:12:10 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20120608103249.GA10321@bloggs.ozlabs.ibm.com>
References: <20120608103249.GA10321@bloggs.ozlabs.ibm.com>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Fri, 8 Jun 2012 11:11:48 -0700
Message-ID: <CA+55aFxy5pAA2rkW-B0nJ0URSe0_S4iO+4A6QaX3A7pV18GF0A@mail.gmail.com>
Subject: Re: [GIT PULL] Please pull powerpc fixes
To: Paul Mackerras <paulus@samba.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Jun 8, 2012 at 3:32 AM, Paul Mackerras <paulus@samba.org> wrote:
>
> BTW, should I be using a signed tag for this?

I don't require signed tags, at least not for git.kernel.org pulls
from people I know and that looks perfectly normal.

That said, about a third of the merges I have done for 3.5 have had
signatures, and it's kind of nice. It's another small nice detail to
have, and the fact that the tag message just automatically makes it
into my merge message buffer is convenient.

So it's not a big deal for something like this (in contrast: for
github or other slighly more anonymous pull requests I *really* prefer
it), but I think it's a nice habit to get into.

Whatever works for you,

            Linus
