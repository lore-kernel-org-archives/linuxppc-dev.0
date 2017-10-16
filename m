Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3yFmgm5fTPzDrJV
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Oct 2017 16:13:40 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Balbir Singh <bsingharora@gmail.com>
Subject: Re: [PATCH v4 1/5] powerpc/mce.c: Remove unused function
 get_mce_fault_addr()
In-Reply-To: <20170929042655.14570-2-bsingharora@gmail.com>
References: <20170929042655.14570-1-bsingharora@gmail.com>
 <20170929042655.14570-2-bsingharora@gmail.com>
Date: Mon, 16 Oct 2017 16:13:33 +1100
Message-ID: <87shejlloi.fsf@concordia.ellerman.id.au>
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

Balbir Singh <bsingharora@gmail.com> writes:

> There are no users of get_mce_fault_addr()
>
> Fixes: b63a0ff ("powerpc/powernv: Machine check exception handling.")

That fixes line is wrong, get_mce_fault_addr() was used in that commit.

The last usage was removed in:

  1363875bdb63 ("powerpc/64s: fix handling of non-synchronous machine checks")

So that's what the fixes tag should point at if anything, I'll update it
here.

cheers
