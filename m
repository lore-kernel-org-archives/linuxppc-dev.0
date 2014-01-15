Return-Path: <linus971@gmail.com>
Received: from mail-ee0-x22e.google.com (mail-ee0-x22e.google.com
 [IPv6:2a00:1450:4013:c00::22e])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 550352C0098
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 19:05:50 +1100 (EST)
Received: by mail-ee0-f46.google.com with SMTP id c13so574396eek.5
 for <linuxppc-dev@ozlabs.org>; Wed, 15 Jan 2014 00:05:47 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1389762075.6933.76.camel@pasglop>
References: <1389762075.6933.76.camel@pasglop>
Date: Wed, 15 Jan 2014 15:05:46 +0700
Message-ID: <CA+55aFyfY5kEezwx8-jhgdgOX+EG__v3QRZmGnGstDpUP-UVWQ@mail.gmail.com>
Subject: Re: [git pull] Please pull powerpc.git merge branch
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=UTF-8
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jan 15, 2014 at 12:01 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> My original intend was to put it in powerpc-next and then shoot it to
> stable, but it got a tad annoying (due to churn it needs to be applied
> at least on rc4 or later while my next is at rc1 and clean that way), so
> I put it in the merge branch.

Quite frankly, I'll prefer to not merge it now, and then 3.13 will get
it from stable, when it does things like this.

Partly because it fixes a power-only bug, but potentially changes
non-power behavior. If it was all in arch/powerpc, I wouldn't mind.

               Linus
