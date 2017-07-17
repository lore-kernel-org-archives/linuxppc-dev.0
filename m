Return-Path: <bsingharora@gmail.com>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9tSM5LCVzDrCs
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 16:20:03 +1000 (AEST)
Received: by mail-pf0-x241.google.com with SMTP id e199so18483446pfh.0
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 16 Jul 2017 23:20:03 -0700 (PDT)
Message-ID: <1500272347.8256.0.camel@gmail.com>
Subject: Re: [PATCH v3 01/10] mtd: powernv_flash: Use WARN_ON_ONCE() rather
 than BUG_ON()
From: Balbir Singh <bsingharora@gmail.com>
To: Cyril Bur <cyrilbur@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-mtd@lists.infradead.org
Cc: stewart@linux.vnet.ibm.com, alistair@popple.id.au, dwmw2@infradead.org,
 rlippert@google.com
Date: Mon, 17 Jul 2017 16:19:07 +1000
In-Reply-To: <20170712042304.19745-2-cyrilbur@gmail.com>
References: <20170712042304.19745-1-cyrilbur@gmail.com>
 <20170712042304.19745-2-cyrilbur@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2017-07-12 at 14:22 +1000, Cyril Bur wrote:
> BUG_ON() should be reserved in situations where we can not longer
> guarantee the integrity of the system. In the case where
> powernv_flash_async_op() receives an impossible op, we can still
> guarantee the integrity of the system.
> 
> Signed-off-by: Cyril Bur <cyrilbur@gmail.com>
> ---

Looks reasonable

Acked-by: Balbir Singh <bsingharora@gmail.com>
