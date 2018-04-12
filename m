Return-Path: <linus971@gmail.com>
Received: from mail-it0-x230.google.com (mail-it0-x230.google.com
 [IPv6:2607:f8b0:4001:c0b::230])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40MSQL4h3QzF1S3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Apr 2018 03:22:18 +1000 (AEST)
Received: by mail-it0-x230.google.com with SMTP id 71-v6so8016611ith.2
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Apr 2018 10:22:18 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <20180412172051.GK16141@n2100.armlinux.org.uk>
References: <20180409152253.GD10489@altlinux.org>
 <20180412013435.GA21219@altlinux.org>
 <20180412095811.GC16141@n2100.armlinux.org.uk>
 <20180412110314.GA28070@altlinux.org>
 <20180412121949.GD16141@n2100.armlinux.org.uk>
 <20180412124928.GA29458@altlinux.org>
 <20180412131404.GE16141@n2100.armlinux.org.uk>
 <CA+55aFxdg2bYHtbKXb4mT5UuP2GH_qjkc=WeZY-RYHWZFQ2Gng@mail.gmail.com>
 <20180412172051.GK16141@n2100.armlinux.org.uk>
From: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 12 Apr 2018 10:22:15 -0700
Message-ID: <CA+55aFwjZqd8J0=veki1g+quQg8amEG4NnMe-h7HFksn=F=x_Q@mail.gmail.com>
Subject: Re: sparc/ppc/arm compat siginfo ABI regressions: sending SIGFPE via
 kill() returns wrong values in si_pid and si_uid
To: Russell King - ARM Linux <linux@armlinux.org.uk>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Dmitry V. Levin" <ldv@altlinux.org>,
 "Eric W. Biederman" <ebiederm@xmission.com>,
 sparclinux <sparclinux@vger.kernel.org>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 12, 2018 at 10:20 AM, Russell King - ARM Linux
<linux@armlinux.org.uk> wrote:
>
> This file was created to contain FPE_FIXME, by the "signal/arm: Document
> conflicts with SI_USER and SIGFPE" commit so if we're removing it, it
> would be better to remove the whole file.

Fair enough. I'm not going to commit that anyway since I can't test
it, but yes, if it tests ok that sounds like the right thing to do.

                   Linus
