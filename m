Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 7C01E1A0BC0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Mar 2015 16:54:39 +1100 (AEDT)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 474C2140140
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 16:54:33 +1100 (AEDT)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id t2H5sTSM002229
 for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2015 00:54:30 -0500
Message-ID: <1426571669.4770.19.camel@kernel.crashing.org>
Subject: Changes to my -next branch
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Tue, 17 Mar 2015 16:54:29 +1100
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

Hi folks !

My -next branch has been somewhat dormant lately. Now that we have that
new two-headed maintainership model, I'll change the way it works.

I'm going to merge patches in topic branches exclusively. One per series
and a next-misc for random other stuff.

"next" itself will just be an aggregate of these and will possibly be
rebased, nobody should work on top of next anyway. If you rely on some
work in any of the topic branches, pull *that*.

The topic branches themselves are meant to have the "don't rebase"
semantics, ie, if such a branch goes into my "nest", it means that
I intend to send it to Linus in my pull request (or via mpe) as-is. I
*might* drop the branch but that is a last-minute fuse thing that
I hope I don't have to use.

I'll start pushing things out tomorrow.

Cheers,
Ben.
