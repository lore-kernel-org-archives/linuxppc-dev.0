Return-Path: <Paul.Gortmaker@windriver.com>
Received: from mail1.windriver.com (mail1.windriver.com [147.11.146.13])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id EDB612C0096
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Feb 2014 01:28:34 +1100 (EST)
Date: Wed, 5 Feb 2014 09:28:25 -0500
From: Paul Gortmaker <paul.gortmaker@windriver.com>
To: Ingo Molnar <mingo@kernel.org>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205142824.GA23780@windriver.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
 <20140205064150.GA31568@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
In-Reply-To: <20140205064150.GA31568@gmail.com>
Cc: linux-arch@vger.kernel.org, Stephen Rothwell <sfr@canb.auug.org.au>,
 linux-m68k@vger.kernel.org, rusty@rustcorp.com.au, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-mips@linux-mips.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, linux-alpha@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

[Re: [GIT PULL] tree-wide: clean up no longer required #include <linux/init.h>] On 05/02/2014 (Wed 07:41) Ingo Molnar wrote:

> 
> * Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> 
> > Hi Ingo,
> > 
> > On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > > 
> > > So, if you meant Linus to pull it, you probably want to cite a real 
> > > Git URI along the lines of:
> > > 
> > >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> > 
> > Paul provided the proper git url further down in the mail along with the
> > usual pull request message (I guess he should have put that bit at the
> > top).
> 
> Yeah, indeed, and it even comes with a signed tag, which is an extra 
> nice touch:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup
> 
> (I guess the https was mentioned first to lower expectations.)

Just to clarify, the init.git was the repo of raw commits+series file
that was used for testing on linux next; now useless, except for showing
the last several weeks of history (hence the visual http link).  The
signed tag [separate repo] is the application of those commits against
the 3.14-rc1 tag, which was the end goal from the beginning.

Does history matter?  In the case of a cleanup like this, it does only
in the immediate context of this pull request; to help distinguish this
work from some short lived half baked idea that also had its testing
invalidated by arbitrarily rebasing onto the latest shiny tag.

I wouldn't have even mentioned the patch repo, except for the fact that
I know how Linus loves arbitrary rebases [and malformed pull requests]  :)

Thanks,
Paul.
--

> 
> Thanks,
> 
> 	Ingo
