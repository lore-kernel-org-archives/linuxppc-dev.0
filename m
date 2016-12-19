Return-Path: <kernelfans@gmail.com>
Received: from mail-it0-x236.google.com (mail-it0-x236.google.com
 [IPv6:2607:f8b0:4001:c0b::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3thw9G0wwJzDwDB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 20:09:54 +1100 (AEDT)
Received: by mail-it0-x236.google.com with SMTP id b132so46729553iti.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Dec 2016 01:09:54 -0800 (PST)
MIME-Version: 1.0
From: Liu ping fan <kernelfans@gmail.com>
Date: Mon, 19 Dec 2016 17:09:51 +0800
Message-ID: <CAFgQCTv4SmBdp91BNKiy6PzijLCzyYHFoezZeqBVbJPwCP=PkA@mail.gmail.com>
Subject: a question about powervm
To: linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi guys,

I am using a pSeries. It runs on powerVM.
My question is whether the cpuX under /sys/devices/system/cpu
corresponds to a real cpu or not.
I think it is not the same as the cpu on kvm-guest, which is emulated
by a linux process.

Thx.
