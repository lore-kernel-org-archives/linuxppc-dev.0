Return-Path: <nicholas.piggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x5XHL6DjWzDq6W
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Jul 2017 14:27:10 +1000 (AEST)
Received: by mail-pg0-x241.google.com with SMTP id d193so11193583pgc.2
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 09 Jul 2017 21:27:10 -0700 (PDT)
Date: Mon, 10 Jul 2017 14:26:53 +1000
From: Nicholas Piggin <nicholas.piggin@gmail.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, Michael Neuling
 <michael.neuling@au1.ibm.com>, "Aneesh Kumar K.V"
 <aneesh.kumar@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2] powerpc/mm/radix: Properly clear process table entry
Message-ID: <20170710142653.366c66e1@roar.ozlabs.ibm.com>
In-Reply-To: <1499517932.3397.22.camel@kernel.crashing.org>
References: <1499517932.3397.22.camel@kernel.crashing.org>
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

On Sat, 08 Jul 2017 07:45:32 -0500
Benjamin Herrenschmidt <benh@kernel.crashing.org> wrote:

> On radix, the process table entry we want to clear when
> destroying a context is entry 0, not entry 1
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

This looks obviously correct to me.
