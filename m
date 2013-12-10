Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x234.google.com (mail-vc0-x234.google.com
 [IPv6:2607:f8b0:400c:c03::234])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 076402C00B2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Dec 2013 14:58:37 +1100 (EST)
Received: by mail-vc0-f180.google.com with SMTP id if17so4072797vcb.25
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 09 Dec 2013 19:58:34 -0800 (PST)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1386640667.32037.53.camel@pasglop>
References: <1386640667.32037.53.camel@pasglop>
Date: Mon, 9 Dec 2013 19:58:34 -0800
Message-ID: <CA+55aFz_VXtkX0vH+T2kGpzA90Zqys=_quJFq3fGT68YTCnBtw@mail.gmail.com>
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

On Mon, Dec 9, 2013 at 5:57 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
>
> Here are a handful of powerpc fixes for 3.13.

Grr.

I've pulled it, but looking at that history, it's just pure and utter
f*cking garbage.

It was rebased *minutes* before sending it, as far as I can tell. Why?

And it has a pointless merge that you must have created with "--no-ff"
for no apparent good reason.

WTF? What the hell happened here, and why? As mentioned, it's in my
tree, but I was *this* close to just unpulling and saying "fuck that"
when I started looking at it.

              Linus
