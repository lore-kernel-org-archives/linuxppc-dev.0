Return-Path: <linus971@gmail.com>
Received: from mail-vc0-x22d.google.com (mail-vc0-x22d.google.com
 [IPv6:2607:f8b0:400c:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 10B012C037D
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 03:10:34 +1000 (EST)
Received: by mail-vc0-f173.google.com with SMTP id if17so2069622vcb.32
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Sep 2013 10:10:32 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
References: <1380270519.27811.10.camel@pasglop>
 <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
Date: Fri, 27 Sep 2013 10:10:32 -0700
Message-ID: <CA+55aFyDfMdAeaniQwkoeW6F-xd3JxrzGYwtFb6N9+NA6aRCMg@mail.gmail.com>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Yinghai Lu <yinghai@kernel.org>
Content-Type: text/plain; charset=UTF-8
Cc: Bjorn Helgaas <bhelgaas@google.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 27, 2013 at 9:01 AM, Yinghai Lu <yinghai@kernel.org> wrote:
>
> So i would like to use the first way that you suggest : call pci_set_master
> PCIe port driver.

So I have to say, that if we can fix this with just adding a single
new pci_set_master() call, we should do that before we decide to
revert.

If other, bigger issues then come up, we can decide to revert. But if
there's a one-liner fix, let's just do that first, ok?

Mind sending a patch?

             Linus
