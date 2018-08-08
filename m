Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41ltxF0fFBzDqgZ
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Aug 2018 00:26:41 +1000 (AEST)
In-Reply-To: <b3d7b6cdb89a48be06a2630bf0d762d9d17d931f.1531511429.git.christophe.leroy@c-s.fr>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, wei.guo.simon@gmail.com,
 segher@kernel.crashing.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [v8,1/4] selftests/powerpc: add test for 32 bits memcmp
Message-Id: <41ltx75dhJz9s9l@ozlabs.org>
Date: Thu,  9 Aug 2018 00:26:28 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-08-01 at 09:01:10 UTC, Christophe Leroy wrote:
> This patch renames memcmp test to memcmp_64 and adds
> a memcmp_32 test for testing the 32 bits version of memcmp()
> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>

Series applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/1bb07b593adc1934a526eb04acfe8b

cheers
