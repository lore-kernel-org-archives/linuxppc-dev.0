Return-Path: <whitebox@nefkom.net>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r7ZQz36YRzDq66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 May 2016 19:09:31 +1000 (AEST)
From: Andreas Schwab <schwab@linux-m68k.org>
To: Florian Weimer <fweimer@redhat.com>
Cc: Alan Modra <amodra@gmail.com>,  linuxppc-dev@lists.ozlabs.org
Subject: Re: ppc64 sbrk returns executable heap in 32-bit emulation mode
References: <5590cf46-aaa2-451e-f21d-acf5f2eb4928@redhat.com>
 <20160516062425.GA24091__32035.8907142237$1463379977$gmane$org@bubble.grove.modra.org>
 <m21t52xu92.fsf@linux-m68k.org>
 <adca8a90-b4ce-f386-5706-0a17b1e91441@redhat.com>
Date: Mon, 16 May 2016 11:09:14 +0200
In-Reply-To: <adca8a90-b4ce-f386-5706-0a17b1e91441@redhat.com> (Florian
 Weimer's message of "Mon, 16 May 2016 10:59:00 +0200")
Message-ID: <m2shxiwerp.fsf@linux-m68k.org>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Florian Weimer <fweimer@redhat.com> writes:

> But my test says that at least part of .bss in the main executable is
> *not* executable.

Build with -mbss-plt -Wl,--bss-plt.

Andreas.

-- 
Andreas Schwab, schwab@linux-m68k.org
GPG Key fingerprint = 58CA 54C7 6D53 942B 1756  01D3 44D5 214B 8276 4ED5
"And now for something completely different."
