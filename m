Return-Path: <linus971@gmail.com>
Received: from mail-vc0-f182.google.com (mail-vc0-f182.google.com
 [209.85.220.182])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EA2562C0299
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jun 2013 07:33:40 +1000 (EST)
Received: by mail-vc0-f182.google.com with SMTP id gf12so3983095vcb.13
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jun 2013 14:33:37 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1370764616.14883.28.camel@pasglop>
References: <1370764616.14883.28.camel@pasglop>
Date: Sun, 9 Jun 2013 14:33:37 -0700
Message-ID: <CA+55aFz_E+x=Mr9Z6_09wzh1mXFr3a2VigPX77LzrsyLUFeb+Q@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 9, 2013 at 12:56 AM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Here are a few more powerpc changes for 3.10. I've merged your
> tree in at some point (which I generally avoid) in order to get
> the compat network fixes as soon as possible.
>
> Mostly regressions, and stuff I judged could/should still go in at
> this stage.

Not pulled, because your hamster smells of eldeberries.

This is not just bugfixes. In fact, as far as I can tell, this
*introduces* bugs, with that "get_user()" in the exception path that
can apparently happen with irqs disabled and will thus potentially
result in new warnings that just make things unreadable.

I'm f*cking tired of people having problems understanding "we're past
rc5". If it's not something you would call stable material, you
shouldn't send it to me.

              Linus
