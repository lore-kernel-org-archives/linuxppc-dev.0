Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ee0-x22f.google.com (mail-ee0-x22f.google.com
 [IPv6:2a00:1450:4013:c00::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8864C2C007E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 17:06:42 +1100 (EST)
Received: by mail-ee0-f47.google.com with SMTP id d49so4674584eek.20
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Feb 2014 22:06:36 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Feb 2014 07:06:33 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Paul Gortmaker <paul.gortmaker@windriver.com>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205060633.GE30094@gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, rusty@rustcorp.com.au, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, sfr@canb.auug.org.au,
 Linus Torvalds <torvalds@linux-foundation.org>, x86@kernel.org,
 linux-alpha@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org,
 linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Paul Gortmaker <paul.gortmaker@windriver.com> wrote:

> On Feb 4, 2014 3:52 PM, "Paul Gortmaker" <paul.gortmaker@windriver.com>
> wrote:
> >
> > We've had this in linux-next for 2+ weeks (thanks Stephen!) as a
> > linux-stable like queue of patches, and as can be seen here:
> >
> >   https://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Argh, above link is meant for cloning, not viewing.
> 
> This should be better...
> 
> https://git.kernel.org/cgit/linux/kernel/git/paulg/init.git/

So, if you meant Linus to pull it, you probably want to cite a real 
Git URI along the lines of:

   git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git

( Otherwise your pull request might be ignored or worse, you might get
  an honest reply, due to the https transport being considered evil
  that no free man outside of corporate firewalls should ever consider
  and all that. )

Nice cleanups btw.

Thanks,

	Ingo
