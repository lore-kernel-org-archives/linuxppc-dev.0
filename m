Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xC7cY4SX7zDrS2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 17:16:29 +1000 (AEST)
Received: by mail-pg0-x243.google.com with SMTP id z1so5880752pgs.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 Jul 2017 00:16:29 -0700 (PDT)
Date: Wed, 19 Jul 2017 17:16:13 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>, Mahesh Jagannath Salgaonkar
 <mahesh@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 1/3] powerpc/powernv: handle the platform error
 reboot in ppc_md.restart
Message-ID: <20170719171613.2fbf30f2@roar.ozlabs.ibm.com>
In-Reply-To: <20170719065912.19183-2-npiggin@gmail.com>
References: <20170719065912.19183-1-npiggin@gmail.com>
 <20170719065912.19183-2-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 19 Jul 2017 16:59:10 +1000
Nicholas Piggin <npiggin@gmail.com> wrote:

> Change this by providing a special crash function which does some of
> the console flushing from the panic() path before calling firmware to
> reboot.

Oops, I changed the changelog but not the patch subject. Should
be something like "flush console before platform error reboot".

Thanks,
Nick
