Return-Path: <mingo.kernel.org@gmail.com>
Received: from mail-ea0-x22a.google.com (mail-ea0-x22a.google.com
 [IPv6:2a00:1450:4013:c01::22a])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id C9C072C0099
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Feb 2014 17:41:57 +1100 (EST)
Received: by mail-ea0-f170.google.com with SMTP id k10so4829654eaj.15
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 04 Feb 2014 22:41:53 -0800 (PST)
Sender: Ingo Molnar <mingo.kernel.org@gmail.com>
Date: Wed, 5 Feb 2014 07:41:50 +0100
From: Ingo Molnar <mingo@kernel.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
Subject: Re: [GIT PULL] tree-wide: clean up no longer required #include
 <linux/init.h>
Message-ID: <20140205064150.GA31568@gmail.com>
References: <1391547118-21967-1-git-send-email-paul.gortmaker@windriver.com>
 <CAP=VYLp+zus5591g-1YQBCJifbk+UY59yJ7rV06ZN3QhhdnK7w@mail.gmail.com>
 <20140205060633.GE30094@gmail.com>
 <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140205172723.3fa841793b3fa3f3f534937f@canb.auug.org.au>
Cc: linux-arch@vger.kernel.org, linux-mips@linux-mips.org,
 linux-m68k@vger.kernel.org, rusty@rustcorp.com.au, linux-ia64@vger.kernel.org,
 kvm@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 x86@kernel.org, Paul Gortmaker <paul.gortmaker@windriver.com>,
 linux-alpha@vger.kernel.org, netdev@vger.kernel.org,
 gregkh@linuxfoundation.org, sparclinux@vger.kernel.org,
 akpm@linux-foundation.org, Linus Torvalds <torvalds@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


* Stephen Rothwell <sfr@canb.auug.org.au> wrote:

> Hi Ingo,
> 
> On Wed, 5 Feb 2014 07:06:33 +0100 Ingo Molnar <mingo@kernel.org> wrote:
> > 
> > So, if you meant Linus to pull it, you probably want to cite a real 
> > Git URI along the lines of:
> > 
> >    git://git.kernel.org/pub/scm/linux/kernel/git/paulg/init.git
> 
> Paul provided the proper git url further down in the mail along with the
> usual pull request message (I guess he should have put that bit at the
> top).

Yeah, indeed, and it even comes with a signed tag, which is an extra 
nice touch:

  git://git.kernel.org/pub/scm/linux/kernel/git/paulg/linux.git tags/init-cleanup

(I guess the https was mentioned first to lower expectations.)

Thanks,

	Ingo
