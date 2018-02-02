Return-Path: <mathieu.malaterre@gmail.com>
Received: from mail-ua0-x241.google.com (mail-ua0-x241.google.com
 [IPv6:2607:f8b0:400c:c08::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zY4gK6xxdzDqZh
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 Feb 2018 05:06:37 +1100 (AEDT)
Received: by mail-ua0-x241.google.com with SMTP id p12so14747738uad.0
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 02 Feb 2018 10:06:37 -0800 (PST)
MIME-Version: 1.0
Sender: mathieu.malaterre@gmail.com
In-Reply-To: <20180202174622.GA7996@lst.de>
References: <CA+7wUsybeT=pdkX7AkiC=JsG2ShDMZF+Z_anxryeJ=UJFHkSYQ@mail.gmail.com>
 <20180202174622.GA7996@lst.de>
From: Mathieu Malaterre <malat@debian.org>
Date: Fri, 2 Feb 2018 19:06:14 +0100
Message-ID: <CA+7wUsw6jee9+PT0JUQ-gSL=A79d-uxSqgNd4LsHkUYn+zXPyw@mail.gmail.com>
Subject: Re: [ppc32] WARNING: CPU: 0 PID: 1 at
 ./include/linux/dma-mapping.h:516 dmam_alloc_coherent+0xd8/0x118
To: Christoph Hellwig <hch@lst.de>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 2, 2018 at 6:46 PM, Christoph Hellwig <hch@lst.de> wrote:
> On Fri, Feb 02, 2018 at 02:11:33PM +0100, Mathieu Malaterre wrote:
>> Hi there,
>>
>> What is this warning all about (system is Mac Mini G4) ? Thanks
>
> What kernel version is this?

I've synced with git/master this morning

$ uname -a
Linux debian 4.15.0+ #335 Fri Feb 2 15:17:38 CET 2018 ppc GNU/Linux
