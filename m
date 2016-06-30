Return-Path: <olof@lixom.net>
Received: from mail-io0-x241.google.com (mail-io0-x241.google.com
 [IPv6:2607:f8b0:4001:c06::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rg9Pw6YrjzDq5d
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 16:59:15 +1000 (AEST)
Received: by mail-io0-x241.google.com with SMTP id s63so7287915ioi.3
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jun 2016 23:59:15 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
References: <4867f9385a2.1e1ca6c1@auth.smtp.1and1.co.uk>
From: Olof Johansson <olof@lixom.net>
Date: Wed, 29 Jun 2016 23:59:13 -0700
Message-ID: <CAOesGMgvNY8YBeyT3uMfD5XyQbhv0ucFtC8EVHS7gwrTmTNzGw@mail.gmail.com>
Subject: Re: [PATCH v2 RFC] pasemi: Fix boot failure on 4.7-rc1
To: Darren Stevens <darren@stevens-zone.net>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, Pat Wall <pjwall@mac.com>,
 Alex Perez <aperez@alexperez.com>, matthew@a-eon.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 "R.T.Dickinson" <rtd2@xtra.co.nz>,
 Christian Zigotzky <chzigotzky@xenosoft.de>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi,

On Wed, Jun 29, 2016 at 1:06 PM, Darren Stevens <darren@stevens-zone.net> wrote:
>
>     Commit:d6a9996e84ac4beb7713e9485f4563e100a9b03e (powerpc/mm:
>     vmalloc abstraction in preparation for radix) turned kernel memory
>     and IO addresses from #defined constants to variables initialised
>     at runtime.
>
>     On PA6T systems the setup_arch machine call initialises the onboard
>     PCI-e root-ports, and uses pci_io_base to do this, which is now before
>     its value has been set resulting in a panic right after 'booting
>     linux via __start()'

I don't see the panic here on a Chitra, at least not on recent -next.

What config are you building with when you see this?

Please cc me on PA Semi related patches if you want my attention. I
still have hardware, in fact I boot every -next release on it through
automation.



-Olof
