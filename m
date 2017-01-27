Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v8g1c45WGzDq6k
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Jan 2017 11:40:36 +1100 (AEDT)
In-Reply-To: <5f910c33-c811-2197-0adb-c55f7722c5a7@users.sourceforge.net>
To: SF Markus Elfring <elfring@users.sourceforge.net>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>
From: Michael Ellerman <patch-notifications@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: powerpc/mm: Return directly after a failed __copy_from_user() in
 sys_subpage_prot()
Message-Id: <3v8g1c1qNZz9tT8@ozlabs.org>
Date: Fri, 27 Jan 2017 11:40:36 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sat, 2017-01-21 at 15:24:58 UTC, SF Markus Elfring wrote:
> From: Markus Elfring <elfring@users.sourceforge.net>
> Date: Sat, 21 Jan 2017 16:10:50 +0100
> 
> * Return directly after a call of the function "__copy_from_user"
>   failed here.
> 
>   This issue was detected by using the Coccinelle software.
> 
> * Delete the jump label "out2" which became unnecessary with
>   this refactoring.
> 
> Signed-off-by: Markus Elfring <elfring@users.sourceforge.net>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/a967f161abc7c4a6936ceb15737f75

cheers
