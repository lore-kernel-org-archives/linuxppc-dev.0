Return-Path: <yhlu.kernel@gmail.com>
Received: from mail-ie0-x230.google.com (mail-ie0-x230.google.com
 [IPv6:2607:f8b0:4001:c03::230])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com",
 Issuer "Google Internet Authority G2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id A15332C010C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Sep 2013 06:14:38 +1000 (EST)
Received: by mail-ie0-f176.google.com with SMTP id as1so6784418iec.21
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Sep 2013 13:14:33 -0700 (PDT)
MIME-Version: 1.0
Sender: yhlu.kernel@gmail.com
In-Reply-To: <1380337550.27811.71.camel@pasglop>
References: <1380270519.27811.10.camel@pasglop>
 <CAE9FiQVkW7d7vFx_kPJG-FEvO71SZjZmpR+dnwVm61wkYK=0YA@mail.gmail.com>
 <CA+55aFyDfMdAeaniQwkoeW6F-xd3JxrzGYwtFb6N9+NA6aRCMg@mail.gmail.com>
 <1380318405.27811.37.camel@pasglop>
 <CAE9FiQXXvkfTak6oEpUog_RYs_Gwpdji7N5UJ=R11Q61==N97A@mail.gmail.com>
 <1380321480.27811.53.camel@pasglop>
 <CAE9FiQWm7ALPO5k_2nV+fuZw4oNNiw+_PEx8EWkb52ymN+EYUg@mail.gmail.com>
 <1380323960.27811.67.camel@pasglop>
 <CAE9FiQV8ipnQ_vV68S-QHMrUrQTWQT_XObxyBeR=dOuw6fG1eg@mail.gmail.com>
 <1380337550.27811.71.camel@pasglop>
Date: Sat, 28 Sep 2013 13:14:33 -0700
Message-ID: <CAE9FiQUnwmANf5x8rw5=QViyVPdi0FLMpSGGnO9u-Twp_YXMpg@mail.gmail.com>
Subject: Re: Please revert 928bea964827d7824b548c1f8e06eccbbc4d0d7d
From: Yinghai Lu <yinghai@kernel.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Content-Type: text/plain; charset=ISO-8859-1
Cc: "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linux Kernel list <linux-kernel@vger.kernel.org>,
 "Rafael J. Wysocki" <rjw@sisk.pl>, Bjorn Helgaas <bhelgaas@google.com>,
 Linus Torvalds <torvalds@linux-foundation.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Sep 27, 2013 at 8:05 PM, Benjamin Herrenschmidt
<benh@kernel.crashing.org> wrote:
> On Fri, 2013-09-27 at 16:44 -0700, Yinghai Lu wrote:
>
> In the meantime, can you properly submit the other one with the warning
> to Linus ? It will make things more robust overall...

https://patchwork.kernel.org/patch/2959121/
