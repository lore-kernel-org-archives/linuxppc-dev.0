Return-Path: <bsingharora@gmail.com>
Received: from mail-qt0-x22d.google.com (mail-qt0-x22d.google.com
 [IPv6:2607:f8b0:400d:c0d::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yCmtK05tSzDrBX
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 13 Oct 2017 10:15:52 +1100 (AEDT)
Received: by mail-qt0-x22d.google.com with SMTP id k31so16578140qta.6
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Oct 2017 16:15:52 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <962487416.5821059.1507639866584@mail.yahoo.com>
References: <962487416.5821059.1507639866584.ref@mail.yahoo.com>
 <962487416.5821059.1507639866584@mail.yahoo.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Fri, 13 Oct 2017 10:15:49 +1100
Message-ID: <CAKTCnznqZ5YgWeU+x61vJtrTQnmC3-i30V+m8G42hWojpM5k0A@mail.gmail.com>
Subject: Re: KASan for powerpc
To: KHUSHAL GUMGAONKAR <khushaluniversal@yahoo.com>
Cc: "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 10, 2017 at 11:51 PM, KHUSHAL GUMGAONKAR
<khushaluniversal@yahoo.com> wrote:
>  Hi Aneesh,
>
> I am facing unknown error in printk  during boot and after that kernel Hangs
> on powerpc with KASan changes.
>

This is probably the worst way to reach out. The reason being

You describe the crash your seeing, there is no description of

1. What machine you tried this on?
2. What MMU mode?
3. What kernel?
4. What gcc version, flags for KASAN
5. What was the KASAN design - how much shadow memory to real memory?

Unless you can work out those details, this is just noise on the list.
I posted an RFC for radix -
http://linuxppc.10917.n7.nabble.com/RFC-PATCH-v1-powerpc-radix-kasan-KASAN-support-for-Radix-td125864.html

It needs work, please read the implementations so far, discuss your
design/understanding. Then we can discuss what issues you are running
into, otherwise it's just noise without effort.

Balbir Singh.
