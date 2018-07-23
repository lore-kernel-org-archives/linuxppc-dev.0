Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Z4h94WY8zDsFc
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jul 2018 01:11:21 +1000 (AEST)
In-Reply-To: <20180718161544.12134-1-muriloo@linux.ibm.com>
To: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: Kees Cook <keescook@chromium.org>, Mathieu Malaterre <malat@debian.org>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Michael Bringmann <mwb@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 =?utf-8?q?C=C3=A9dric_Le_Goater?= <clg@kaod.org>,
 Bharata B Rao <bharata@linux.vnet.ibm.com>,
 Nathan Fontenot <nfont@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [v2] powerpc/prom_init: remove linux,stdout-package property
Message-Id: <41Z4h91xc7z9s9J@ozlabs.org>
Date: Tue, 24 Jul 2018 01:11:20 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2018-07-18 at 16:15:44 UTC, Murilo Opsfelder Araujo wrote:
> This property was added in 2004 and the only use of it, which was already inside
> `#if 0`, was removed a month later.
> 
> Signed-off-by: Murilo Opsfelder Araujo <muriloo@linux.ibm.com>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/ec9336396a98f61290f45e8bb94245

cheers
