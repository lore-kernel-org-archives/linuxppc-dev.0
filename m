Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rjc772FrYzDqFD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jul 2016 16:09:55 +1000 (AEST)
In-Reply-To: <1467593044-10600-1-git-send-email-oohall@gmail.com>
To: Oliver O'Halloran <oohall@gmail.com>, linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: mikey@neuling.org, Oliver O'Halloran <oohall@gmail.com>
Subject: Re: powerpc/mm: Add a parameter to disable 1TB segs
Message-Id: <3rjc771dmCz9sCg@ozlabs.org>
Date: Mon,  4 Jul 2016 16:09:55 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2016-04-07 at 00:44:04 UTC, Oliver O'Halloran wrote:
> This patch adds the kernel command line parameter "no_tb_segs" which
> forces the kernel to use 256MB rather than 1TB segments. Forcing the use
> of 256MB segments makes it considerably easier to test code that depends
> on an SLB miss occurring.

That's a fairly awful name :)

Can you call it "disable_1T_segments" ?

It should also be mentioned in Documentation/kernel-parameters.txt, with
emphasis that it's a debug option and powerpc only.

cheers
