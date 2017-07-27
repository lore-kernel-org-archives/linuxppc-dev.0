Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xJBkq2txdzDrTg
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Jul 2017 22:54:27 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@lists.ozlabs.org <linuxppc-dev@lists.ozlabs.org>,
 LKML  <linux-kernel@vger.kernel.org>
Subject: New "merge" branch in the powerpc repo
Date: Thu, 27 Jul 2017 22:54:26 +1000
Message-ID: <874ltyf3b1.fsf@concordia.ellerman.id.au>
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

Hi folks,

tldr: There's a new branch in the powerpc repo called "merge", and if
you're doing work that's targeting the powerpc tree then it is probably
a good base to work on top of.


It's a merge of Linus' master branch, my current fixes branch, and my
current next branch. If we have significant chunks of code in another
tree, eg. akpm's then I may also merge that in, but that will be done on
a case-by-case basis.

Think of it like a mini linux-next, just for powerpc stuff :)

I'll keep it up to date whenever I update either of my branches, and
semi regularly when Linus updates his.

The branch itself will never merge with Linus' tree, but the component
parts will eventually (unless they ever need to be emergency rebased).

It's here:

  https://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux.git/log/?h=merge

And also approximately mirrored to here:

  https://github.com/linuxppc/linux/tree/merge


Feel free to ask me here or on IRC (or IBM slack) if you have any
questions.

cheers
